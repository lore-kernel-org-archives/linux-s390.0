Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4644ADD89;
	Thu,  2 Jul 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000066; cv=none; b=Wgz6tPZ5O1vFuwQudoTJEn96b9dgMO5MSu09jAY/fY0mD7RBcRU9fEMGdkoZ2TiobugYXVC6vY07Byy61lAWrlIhyAR33P3EAeqlxaNSoT6nNPb3an+8wtlZwcVQZOot8X2yzyjY1R3d60BdLZ+wlYfmVxIKALacp3hX7+4+Brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000066; c=relaxed/simple;
	bh=7V0NTLHBpsL8AoaSDAOMjcBo+lQIN0J47/cXRYpRPPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH4w4K16QRvxa0H7RENL7/YQGdkKp5G3l85b0yt0nJEIdjPiKavunL3j/BSamvYWA8tME4i6/OfjdUBCktvBE/4ritX6LKvBqm3PljrNUGatEQBznyT8lY3FaS90ARGKf7Pul4EiFKhWdpPWWa7G8zYvkuqTLapmxqDu4jfxQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFPIDQwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFPIDQwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AFA1F00A3A;
	Thu,  2 Jul 2026 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783000064;
	bh=7+4RPXWq0sLT4EC9giNUS42X6L6ymGhyY95vN1pSoHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nFPIDQwIPH19qZY0KdZIF0OqTnY30f1TYEmARp3ZaCpQ9jfD6iYoKRcGHpf9dmS3/
	 edR8ZSu+zdQq6Dvcq1lBcJSgfVriFf5auqL7ebJU8tffvnfbRBm3ZYwUjfjtALVCty
	 ZLYuAobaRM1h6UGAdDFcGBrwV1nvHMKNR5Esk1crHtrt2z4UITnu0PYV999TKPCSuo
	 SCtNHCIYFGCzJq2b2NJCfti4LL5z+GI/0+IqYFp4TEynUdL5YfVhonCcxefDmm5klY
	 h6hiQYiHPqP0wJNLOE6DwgkIExj1ta6AG4wkPKVu3yLjBWlTIPxaQj+ws+QBGcKsbV
	 nLvgFGreL0ACQ==
Date: Thu, 2 Jul 2026 15:47:41 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linaro-mm-sig@lists.linaro.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Yury Norov <yury.norov@gmail.com>, linux-media@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-s390@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>, Mike Rapoport <rppt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	Maxime Ripard <mripard@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	John Stultz <jstultz@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, Sumit Semwal <sumit.semwal@linaro.org>, 
	Will Deacon <will@kernel.org>, Thierry Reding <treding@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, linux-tegra@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, "T.J. Mercier" <tjmercier@google.com>, 
	David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v3 02/11] dt-bindings: display: tegra: Document memory
 regions
Message-ID: <akZr1mzrkyidju53@orome>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-2-d80f7b871bb4@nvidia.com>
 <178293559078.1610192.17087150631381044391.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qagealkznxwhby33"
Content-Disposition: inline
In-Reply-To: <178293559078.1610192.17087150631381044391.robh@kernel.org>


--qagealkznxwhby33
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 02/11] dt-bindings: display: tegra: Document memory
 regions
MIME-Version: 1.0

On Wed, Jul 01, 2026 at 02:53:11PM -0500, Rob Herring (Arm) wrote:
>=20
> On Wed, 01 Jul 2026 18:08:13 +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Add the memory-region and memory-region-names properties to the bindings
> > for the display controllers and the host1x engine found on various Tegra
> > generations. These memory regions are used to access firmware-provided
> > framebuffer memory as well as the video protection region.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v3:
> > - document properties for VIC
> > ---
> >  .../devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml |  8 ++=
++++++
> >  .../devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml  | 10 ++=
++++++++
> >  .../devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml   | 10 ++=
+++++++-
> >  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml          |  7 ++=
+++++
> >  4 files changed, 34 insertions(+), 1 deletion(-)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/d=
isplay/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names: 'anyOf=
' conditional failed, one must be fixed:
> 	'maxitems' is not one of ['$ref', 'additionalItems', 'additionalProperti=
es', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dep=
endentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', '=
enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', '=
minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', '=
patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevalua=
tedProperties', 'uniqueItems']
> 	'type' was expected
> 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/d=
isplay/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names:items: =
{'enum': ['framebuffer', 'protected']} is not of type 'array'
> 	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/d=
isplay/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names: Additi=
onal properties are not allowed ('maxitems' was unexpected)
> 	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/d=
isplay/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names:items: =
{'enum': ['framebuffer', 'protected']} is not of type 'array'
> 	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/d=
isplay/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names: Additi=
onal properties are not allowed ('maxitems' was unexpected)
> 	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml

Ugh... looks like these are all because I mistyped maxItems as maxitems.
Oh well. Sorry for the noise.

Thierry

--qagealkznxwhby33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpGa/wACgkQ3SOs138+
s6FjYBAAiIaBIWdZjFXo82rzspIHpvGgfQhSt4a55q2oojIy6N1UmTKiAcJDv5oW
g8aamgHNh028eD+y5O//mo8BgJnGgvSRFyZ5oH94ydn2FQyK09IRUTJVHXmZzij2
+yZ9kKvyJ8LNB08ozD6+GiG4mxobGEPJile7TvkPBR1IIHTcj72lUtBx1CmXMh2b
vkf7mcrVS0SdxnSoB3SOQGuGp0DV3apzKI/1ufoc+D0N/OfGuORq+/94WVM6HoP7
jORXz/xD1A49PqM9SzGgcVzd2Lm1Latg393tFhznCSVdaPw+OJ4ckF75rTIHAh7t
l95RTj9kj1PhQGZogzjAlCPm9hAWJdHu+GRkO2SY0wGPb4TD2/dLEgUr9Cckce1Y
V7yOCjHLpTgLS33V5O0Bx0NrtOJSs96jUl3pXjSGH1hvb3oZT1WjIA5PzlW44COY
uFHhHIvff1c156UMtRj5zlO5CnKXUKEoYhIrLkFyGrJKRiKh9OS33SAkvkoV1y7s
+BOjmuSA/MHXq6cg6S7Kg6NUGFo/c2KJs9t/5z787NDvmCMYlFgzkjIMFoIh21P9
gHRn3FS98btWp0qlVqv0R6N3sg/suUVCNco6ZMbhEDGafxejqTNRdwipjnb+hxNp
/rlf42/+2WRXWgWDUy0h+bRrMtgHxa6OTPo57aAfd7QkWrSM8tk=
=AE/S
-----END PGP SIGNATURE-----

--qagealkznxwhby33--
