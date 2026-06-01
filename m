Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773F39B4BB;
	Mon,  1 Jun 2026 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332847; cv=none; b=Ov39bbFww1R+vAxjuqkufyncZOcK29dl9vGJ2jMpo3stIdRUt8qvx1aPbr6Bj1y07kMQsZPJnxBH9KZM2fYucPZQIZtyyJMLHBNKejfF92PVIbRf9LAJ3it8YfliIr7gdzgnEhlv2SHkyDpqs/Allff2n4GlCu/DXas1hu5Ftq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332847; c=relaxed/simple;
	bh=BaHPl2b/jO+xhJdx44dgLRKJvbOveIqbphK/IW0KPG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IqOt8SnzpcY3XE8bXG0iTD3NMveaabr3AsgY26w6GnfsSWYMTtkMkqxW0qTc510oe2ATSL8DfFF0WITUbsx5Ebn1SpDEGcrYPwaZ9oB0M3T1LrUEsgOEIq0QPi7BjRVnJ6ya2CSzkJehgWvQzH6Ksu3xxdVeaOWoFVoVcawXGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WbGf3Bp1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WbGf3Bp1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BaHPl2b/jO+xhJdx44dgLRKJvbOveIqbphK/IW0KPG0=; b=WbGf3Bp1onixyilqJoFLMVuDDX
	xfwSGdsk87rzEOLDBdp4Bx2c89gOsDAGYPPAdkTfOITephPZag093OgWS3zSuJG/3GVKcUGFC255R
	BqIYZ8EvldiqEC4KO43RGxfX2YryTuqkrPAnZ3JLCFS3/HnM5+cShi7SckJP/RQT0ScA25etKqMWu
	CcPUd6IoxebwaMxR+v3PWZ5fZxSW/4f0d+Na04t/6qu1AjKjSxQFgsN90qdGU0J6RxfCe048Ih3HS
	9DetvR7vgyZd2+mBBygfHDrLzC8BGl2IEb9jMPOix43F0xsKBc9KCFrHfQAv+k8KdhODb78VrzyKj
	jiP38LJw==;
Received: from [2001:8b0:10b:5:5b40:b57d:669c:36f4] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU5te-00000000RBj-2Hjz;
	Mon, 01 Jun 2026 16:53:51 +0000
Message-ID: <0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
From: David Woodhouse <dwmw2@infradead.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Wen Gu <guwen@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>, 
 tglx@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com,  pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,  jstultz@google.com, anna-maria@linutronix.de,
 frederic@kernel.org,  daniel.lezcano@kernel.org, sboyd@kernel.org,
 vladimir.oltean@nxp.com,  wei.fang@nxp.com, xiaoning.wang@nxp.com,
 jonathan.lemon@gmail.com,  vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,
 svens@linux.ibm.com,  nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com,  bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org,  imx@lists.linux.dev,
 linux-s390@vger.kernel.org, dust.li@linux.alibaba.com, 
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com, 
 taniya.das@oss.qualcomm.com
Date: Mon, 01 Jun 2026 17:53:49 +0100
In-Reply-To: <ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
	 <20260407104802.34429-3-guwen@linux.alibaba.com>
	 <20260412084704.743482ad@kernel.org>
	 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
	 <20260412095301.4fe1fe65@kernel.org>
	 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
	 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
	 <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
	 <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
	 <ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-VlDPaE1pzXHdYpveufIV"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-VlDPaE1pzXHdYpveufIV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 08:20 -0700, Richard Cochran wrote:
> On Mon, Jun 01, 2026 at 08:03:26AM +0100, David Woodhouse wrote:
> > If we move all the plain non-network PHC drivers (which, as noted,
> > is
> > basically *all* of them) into a drivers/ subdirectory, then perhaps
> > we
>=20
> Sorry, just catching up here, so the idea is to have
>=20
> =C2=A0linux/drivers/ptp/drivers=C2=A0 ?

That is my current suggestion.

It stems from Jakub's response in
https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/ that "I
really wish someone stepped up and created a separate subsystem for all
these cloud / vm clocks. They have nothing to do with PTP."

There was some further bikeshedding in
https://lore.kernel.org/netdev/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.a=
libaba.com/
around how to split 'emulated' from other hardware drivers, but I don't
much like that taxonomy. Some of these "virtual" clocks could just as
easily exist in hardware with PTM too.

My observation is that with the sole exception of ptp_inet.c, *all* of
the actual PHC drivers that live in drivers/ptp instead of drivers/net
are "pure clock" drivers, so perhaps we split those all out into
drivers/ptp/drivers/ and exclude them from the netdev maintenance?

I'm reluctantly prepared to host and help maintain a drivers tree if
it's necessary, but equally as happy to let you own it.=20



--=-VlDPaE1pzXHdYpveufIV
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwMTE2NTM0
OVowLwYJKoZIhvcNAQkEMSIEIM6KxngPB0di1Tja+BOQxhXkaoH9rylPF9YhDjy/9yAOMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAqvOuiJ+HFg1p
ZRPKKYA4u+TuISYFfF7B0qRzbKya3iTbaiwg4gC6mFKcL66SX3PGEHYBo32VOiYAWVF4FY+xyLGz
hDvaTyGgqm+gejCwb6g3TdR0AITDEezZa0L6elqwuB3dEKK/tY6JeFNjaUEalhS37mZjkGWKgGEY
PKQ4zol/zrgrJskOpUMRBSF1L+FYnxpI8HQEa3gFYbyy7V4C4l/kAYdaXU+Ah0CZ//FT0lL07VjD
Xj0dVbu/96PBWe2gbtnvrOqA9GFzPShrOPUyDhSZ+XycwIaKasiUO46sdJKL3LM5+4kL7ydcHQwh
0V5zHbVldzgRQRaFrZrNQ6ZnZbqZ4VsPYLaBJPpuvhNMY9uo6wGWm23uLj2kl7gaWETde3Y+Wax/
RVA9F0SvrBl3cGd0000gF6lVxefnP/3IONZ8omDWZW4XNQssqbkcJmO7SXlOLcogppOiZ0ftgiM3
hgoL1F6MkqAN7OuyPG6oA+KvXtlhW7v/LTjMqIsti0NctDto81ESAqLJo5rWuUanGHPAzLwVqUYd
YFdLXxdv7la/CqxDLCbm7xAd5s+aBt4HBfXur9V+3NxWTFLd7uyUK2t62Scz9se176/X9yCC0xf6
eAtd3NoNnkJY5yLJwhUxRun8xSm5D/aj1LN7WstgAZVnyayCS1hxgY1/s2IVWvkAAAAAAAA=


--=-VlDPaE1pzXHdYpveufIV--
