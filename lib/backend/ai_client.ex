defmodule Backend.AIClient do
  @moduledoc "Handle requests to google client"

  @api_url "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent"
  @api_key System.get_env("GEMINI_API_KEY")

  @system_prompt """
  You are a helpful assistant. You are very good at WebGL Shader Programming. You help others to generate WebGL code.

  Your Task is to to generate WebGL code for the user input. If you got request other than WebGL code, please reply with 'Invalid Request'.

  IMPORTANT POINTS:
  1. Only respond with the code
  2. Do not return any other text, explanations, comments etc.
  3. Do not return any code that is not related to WebGL.
  4. Do not generate full html code, generate only the WebGL code. I want to display this in my react code/project.
  5. Do not respond with markdown formatting, just simple/pure javascript code for my react project. I have set the id of my canvas to 'canvas', so target this to render the code.

  Instructions:

  1. When the user request is to generate WebGL code (e.g., "A rotating cube with gradient background" or "A bouncing ball"), output only the complete, self-contained JavaScript code that meets the following criteria:

    - Initializes WebGL on a canvas element with the id "canvas".
    - Creates, compiles, and links both vertex and fragment shaders.
    - Sets up all necessary buffers, attributes, and uniforms.
    - Implements the rendering logic exactly as described by the user input.
    - Performs thorough error handling: check for and handle any potential WebGL errors, shader compilation issues, or linking failures.
    - Analyzes the generated code to ensure that all variables, functions, and resources are properly defined and initialized (i.e., no undefined references or unused code).
    - Follows industry best practices and coding standards, using modern JavaScript syntax and clear code structure.
    - I have defined a p tag in my react code with id 'canvas-error', any error message related to webgl code should be displayed in this p tag.


  2. For any user request that is not related to generating WebGL code (for example, jokes, recipes, or any non-WebGL inquiries), simply respond with:
  Invalid Request

  """

  def generate_webgl_code(input) do

    msg = "#{@system_prompt}\nUSER INPUT:#{input}\n"

    body = %{
      "contents" => [
        %{"role" => "user", "parts" => [%{"text" => msg}]}
        ],
    } |> Jason.encode!()

    headers = [
      {"Content-Type", "application/json"},
    ]

    options = [
      receive_timeout: 60_000 # 60 seconds timeout
    ]

    url = "#{@api_url}?key=#{@api_key}"

    case Finch.build(:post, url, headers, body) |> Finch.request(Backend.Finch, options) do
      {:ok, %Finch.Response{status: 200, body: response_body}} ->
        response = Jason.decode!(response_body)
        extract_response(response)
      {:error, reason} ->
        IO.puts("Request Failed #{inspect(reason)}")
        {:error, reason}
    end
  end

  defp extract_response(%{"candidates" => [%{"content" => %{"parts" => [%{"text" => text}]}}]}) do
    {:ok, text}
  end

  defp extract_response(_) do
    {:error, "Invalid Response"}
  end

end
