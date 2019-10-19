defmodule Speakers.Player do
  @moduledoc false

  alias Speakers.NifAudio
  alias Speakers.PlayerValidator

  @spec add_to_queue(String.t()) :: :ok | {:error, String.t()}
  def add_to_queue(url) do
    with {:ok, url} <- PlayerValidator.is_valid_uri(url) do
      NifAudio.add_to_queue(url)
    else
      {:error, _} -> {:error, "not a valid audio URL"}
    end
  end

  @spec pause :: :ok | :error
  def pause() do
    NifAudio.pause()
  end

  @spec resume :: :ok | :error
  def resume() do
    NifAudio.resume()
  end

  @spec get_queue_len :: {:ok, integer()} | :error
  def get_queue_len() do
    NifAudio.get_queue_len()
  end

  @spec get_volume :: {:ok, float()} | :error
  def get_volume() do
    NifAudio.get_volume()
  end

  @spec set_volume(float()) :: {:ok, float()} | {:error, String.t()}
  def set_volume(new_volume) do
    with {:ok, volume} <- PlayerValidator.is_valid_volume(new_volume) do
      NifAudio.set_volume(volume)
    else
      {:error, _} -> {:error, "volume must be between 0.0 and 1.0"}
    end
  end
end
