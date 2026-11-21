Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223831;
	b=srBavq3Q6cHLoLnQpTlp9uPfNIQFvqjKYtu/dqcVIbDvgCwwGym5WrpeEr298mfvav6D
	 i/SgL6aKEo9YoGNTHt7iL7i/GsXOAhuw1CdJyVXddC7PBbiMwGfJ7LHbezbFs/+sqnnht
	 EprhjgsRhzVlxkAMcsP9cyV6NYRGbnVvyttSLeOX1BdIvl4jGAOUeD5ig9NoeKuhBa5el
	 iik0uveIGL3YIrEMewzKPhdUzLvJs+7cLjTN4Dkz2hmIoMSURxiF40xACUQEjp13UMWXN
	 ucrWcfpUmK/F9TQEYt9p6n8rjCy88OCr0BKuEoQivxAhDa7vlxyLf2ihth58rCnqM8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223831;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To;
	bh=QklyuLab+Ko9mnpTo5UeclQww95mzIqhLo3F7I/BQkg=;
	b=wFVV4gYWrx01cnFSnadL5PevvX3j04xWSPddAXakIWD+eXJLlH0ZIsjFZradl0gada+n
	 JWzLydX9rKP6CIQV2qLNrY/ZqZ5EMrmfpRIwH1B540gc1VhzEDXMsJteCDMgoC34CYI1f
	 CzYDVn2+X4WE+Sa04XwHimGmnBk4XJmNdxBfyBVxB5adOkHWqJFerm/lZ8GEw46B00xjo
	 DPlVj6KH+VTyxJ9o2qucMHz6wvor4wnvxkz44NEur9Prs+VGLzqW5ZhTQk+dn4sTFo413
	 3DnR9KY3K1+EMFmWNRgAAyR35ktqZd2fCn1lWZoHm43YAe/vDLZosZZjqhdCOBLDO+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gm8eJtOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C352606A684;
	Sat, 21 Nov 2026 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gm8eJtOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE01B1F000CA;
	Sat, 21 Nov 2026 01:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795223829;
	bh=QklyuLab+Ko9mnpTo5UeclQww95mzIqhLo3F7I/BQkg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=gm8eJtOHhBnaOZe7LwDMFJ8mofPVVmX1YGRFpGCBO2m5hz8UlzXX+WvNJUsq934h9
	 Gtdb+AerXFQPif6SLfOq2/dWtEgcQTz7bh3I6KV8pXYeGgzuMqRHyjcJnn/Sn8iwhx
	 YAqVTjTNfeSW2VdEJcGvIBkg4/J19L82jz9PAn9h9IkH5umIAy3FYAYFk2uVRLQd+T
	 s94/ADqCteDEcqO9mcewjaHUBrR90XdQUJorq/NHZbaKSRZNalAGYYTXYCWvSW+hsc
	 zi51JiNKnL+ynxLP/WhWXj9KNLrvetlXTYZdQhOtRoJb5Hc2rzkXDPGGzjDTCgK7xr
	 LOe4azsm+AuJg==
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Nov 2026 02:16:56 +0100
Message-Id: <DN0HQBTG5VUY.1F40HSFIRRGNQ@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Johan Hovold"
 <johan@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Nipun Gupta"
 <nipun.gupta@amd.com>, "Nikhil Agarwal" <nikhil.agarwal@amd.com>, "Ioana
 Ciornei" <ioana.ciornei@nxp.com>, "Longfang Liu" <liulongfang@huawei.com>,
 "Julian Ruess" <julianr@linux.ibm.com>, "Ankit Agrawal"
 <ankita@nvidia.com>, "Brett Creeley" <brett.creeley@amd.com>, "Giovanni
 Cabiddu" <giovanni.cabiddu@intel.com>, =?utf-8?q?Micha=C5=82_Winiarski?=
 <michal.winiarski@intel.com>, "Eric Auger" <eric.auger@redhat.com>, "Eric
 Farman" <farman@linux.ibm.com>, "Matthew Rosato" <mjrosato@linux.ibm.com>,
 "Tony Krowiak" <akrowiak@linux.ibm.com>, "Jason Herne"
 <jjherne@linux.ibm.com>, "Harald Freudenberger" <freude@linux.ibm.com>,
 "Holger Dengler" <dengler@linux.ibm.com>, "Haiyang Zhang"
 <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui"
 <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Mark Brown"
 <broonie@kernel.org>, "Abel Vesa" <abelvesa@kernel.org>, "Stephen Boyd"
 <sboyd@kernel.org>, "Brian Masney" <bmasney+clk@redhat.com>, "Jerome
 Brunet" <jbrunet+clk@baylibre.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Srinivas Kandagatla" <srini@kernel.org>, "Sylwester Nawrocki"
 <s.nawrocki@samsung.com>, "Liam Girdwood" <lgirdwood@gmail.com>, "Jaroslav
 Kysela" <perex@perex.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Bradley Morgan" <bradley.morgan@linux.dev>, "Armin Wolf" <W_Armin@gmx.de>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, <linux-doc@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Mostafa Saleh" <smostafa@google.com>,
 <kvm@vger.kernel.org>, <qat-linux@intel.com>,
 <virtualization@lists.linux.dev>, <intel-xe@lists.freedesktop.org>,
 "Vineeth Vijayan" <vneethv@linux.ibm.com>, "Peter Oberparleiter"
 <oberpar@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 <linux-s390@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, <linux-clk@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-sound@vger.kernel.org>, "Takashi Iwai" <tiwai@suse.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 00/10] driver core: Disable driver overriding by
 default
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>

On Fri Nov 20, 2026 at 12:11 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> It is sensible to merge the driver core change (patch #1) together with
> the individual driver patches setting .support_driver_override because
> with the driver core change the driver override doesn't work any more
> for the unmodified drivers (unless the new kernel parameter is provided
> and a taint is accepted). So I suggest (once there is agreement that the
> patches are fine) to merge them all in one go and provide a stable
> branch in case a driver was missed to be adapted. I can create such a
> branch and ask Greg or Linus to pull it, or Greg can do that.

I think it should be good enough to just take them all through driver-core.=
 If
it turns out in linux-next that we missed a driver we can always add anothe=
r
patch to the driver-core tree.

Those patches only set support_driver_override =3D true, so there shouldn't=
 be
interactions with other trees.

So, let's keep it simple. I can pick this up once we have all the ACKs.

Thanks,
Danilo
