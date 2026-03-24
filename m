Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE338BF91;
	Tue, 24 Mar 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345259; cv=none; b=XsfZ129RPF/n/FdfyseaxEQcWwymHIUFqSw25wOP2mZ6Ljiq4SQOlA51FA/1SO1MUupRRBeJ2t8yupZ8gUqdRSbEWnO7U5Yrz5QWKL9uizePrPpsdEXVoB5z4PVo1weXg6x/wkCZcRp0RKqZSaSaPdluQbitjHUXMZg26dsW9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345259; c=relaxed/simple;
	bh=RMxVm7Zo5XWBccYH6IoXmxOwybfFui0IIwUbhA+EJ9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rylJopz64DxREBPUzJS4r5aTeXF5qgzQMEuCHfgpyBz5HtDT0sm5FuFDiroBvSEEpxRWcgALOr1/9fx85MiSBF5v202mFetDV61Et8/FhJFnoHAgAoGMrgmUpYhZVN2neFPetqzj2b4j+nxEuH7sWnDqFxXoSQpSxzdJmwqVy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OJ+MtAl5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OJ+MtAl5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PIEqeZQtnor87BiNReyNnJCs1E214P6g2jwjej+SP2I=; b=OJ+MtAl5+7vCazSdemAt2Cb1Kj
	cLRq4tcOzjbzDBnxK3iM3OWMW4YsiAkjUR7/I022VKZEIbqkoWWZGtv68mfiKhfFgL9QlNP7pXg+b
	A8DvdRrTFeOMUhXthfXbtM4d1ytmjo5TOeuFU7fxPRbk64gOtAiJ/d8YuMHv87q+azyDLJIx34trY
	XdX2AWMEvjCQ/9fGQu0bwGQsPy0rnHYR1MP60c9os3vXkRtus3VC6aRqObIEAQXiG0zXUnATZaE8r
	Mwh/C/ZT61mTgCsS+RIpwXjZEIBXUoUKjPvhPiRI6MMXcNf1QuvrI6YhiJmFD0CjFQoG8ThND0sc/
	XjInDSZQ==;
Received: from [172.31.31.148] (helo=u09cd745991455d.lumleys.internal)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4yFe-00000003ffk-0tSF;
	Tue, 24 Mar 2026 09:40:42 +0000
Message-ID: <74a6bc560ba40a540b050f505049917c040a3327.camel@infradead.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
From: David Woodhouse <dwmw2@infradead.org>
To: Wen Gu <guwen@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>, 
 "Luu, Ryan" <rluu@amazon.com>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com,  linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jstultz@google.com,  anna-maria@linutronix.de, frederic@kernel.org,
 daniel.lezcano@kernel.org,  sboyd@kernel.org, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com,  jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,  svens@linux.ibm.com,
 nick.shi@broadcom.com, ajay.kaher@broadcom.com, 
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 linux-fpga@vger.kernel.org, imx@lists.linux.dev,
 linux-s390@vger.kernel.org,  dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org,  imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Date: Tue, 24 Mar 2026 09:40:42 +0000
In-Reply-To: <025b7816-ca8e-4cea-bb84-bf324c8c3b22@linux.alibaba.com>
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
	 <20260318073330.115808-3-guwen@linux.alibaba.com>
	 <20260323192232.3a5205dc@kernel.org>
	 <025b7816-ca8e-4cea-bb84-bf324c8c3b22@linux.alibaba.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-OeR6bRPux76fm7jBAgkh"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-OeR6bRPux76fm7jBAgkh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-03-24 at 11:46 +0800, Wen Gu wrote:
>=20
>=20
> On 2026/3/24 10:22, Jakub Kicinski wrote:
> > On Wed, 18 Mar 2026 15:33:30 +0800 Wen Gu wrote:
> > > +PTP EMULATED CLOCK SUPPORT
> > > +M:	Wen Gu <guwen@linux.alibaba.com>
> > > +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > +L:	linux-kernel@vger.kernel.org
> > > +S:	Maintained
> >=20
> > I thought David W was supposed to be the main maintainer?
> > Two moderately known developers from a single vendor/company
> > is not enough to delegate this IMO.
>=20
>=20
> Thanks for pointing this out.
>=20
> We would also very much prefer for this area to be maintained
> by people with deeper expertise in the clock/timekeeping domain
> (such as David). The reason David was not listed in this version
> is that an earlier attempt to ask about maintainership did not
> receive a reply[1]. So we avoided adding without confirmation.
>=20
> If David has no objections to being listed here, that would
> definitely be preferable from our perspective. Other suggested
> clock/timekeeping experts would also be very welcome.
>=20
> [1]
> https://lore.kernel.org/all/78489ff1-c2fa-47dc-beb4-54e9410f7d5c@linux.al=
ibaba.com/

Apologies for missing that; yes I'm perfectly happy to be listed as a
maintainer. Thanks for checking.

Still mildly uncomfortable with 'emulated' as the word we chose for the
non-ieee1588 clocks, although there's only so much bikeshedding we can
do and it's ultimately cosmetic.

I see it more as precision RTCs which provide accurate CLOCK_REALTIME
(ideally including UTC not just TAI) =E2=80=94 largely to virtual guests bu=
t
also on bare metal.

But as long as that's just a nitpick about what the directory is
called, and not an ongoing disagreement about which drivers land where,
I guess it doesn't matter much?

I don't actually want to see many new drivers added here. Going back to
what someone (Jakub?) said in a thread a while back about a pile of
cloud vendors' NIH cruft... I built the vmclock specification
deliberately to be vendor-agnostic and (I think) even implementable in
hardware with PCIe PTM, and I hope that we can consolidate on that and
stop inventing new crap.

https://uapi-group.org/specifications/specs/vmclock/

The next thing I want to do is make the kernel's timekeeping sync from
that as a proper feed-forward clock based on counter readings, instead
of the feedback adjustment that the current NTP hooks permit. And make
it possible to *export* the host's CLOCK_REALTIME to guests in vmclock
form.

--=-OeR6bRPux76fm7jBAgkh
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMyNDA5NDA0
MlowLwYJKoZIhvcNAQkEMSIEIH9AgyXj1TkdQmobZwi3meVlmBm4J9wuV4bWqskWYJ9uMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAkq5L57xsgFOc
CsBniwIK1ik5yk3ocipPC/NStcyVcymM8cXZEb5o2zLlmHdtJ8fXRStawTEk+H1c2dAn4HK2Cm1H
vxcN2vf+5P89I+9cjBR67c8QjSKXxoA/nDvWJ0QBz90nXf4teiU0nj4AeIJ8LagbL/PbQ//K4b+o
Ew3T3pHXDvJiuPn2w7iCG14miKTzyvutL26ScnK+bv+Kqzbbq+NwukJa7cBFuaWSXJ3YPA8smABy
MEki6VwZQvgH0teeufNgsbXZ9mn0ZSbe7c/+Oofv3H+BMQmaUuQli+FckgL1w/Q237lVqvgKXTkV
uX07VIz5QHhsbllWnq51zpWAmXGbBqPUqV77H7Tf2Qyl66c9IP82aHl5sY82lm1m0dwEDumJqal8
5/EXnA9TmziO/TwXpjkSbugqFOwTT3a5QnrCTQgh4S5GtEnIcmqFNfvToB/0j9dwxdSDR3P2uMbz
5dxlCuvuScUEcBJ9JUisbXkQYuSbp7rJWFqls5ZCzAKlUU0jGFdP3/Qgvdvybul2nV31csxQhuxu
jWqc9+XI152g7UtEV9GZdh/05MZR4HZSpX4CQZoZu2xPtYkWBQwal4gobCO8xOCIQMXICo8/TORe
Pb4SzCpOb8Tb2iDfK2h7gqsMxiyQPjbkAFSvCd9NWQRyJxE6+jpJF/7MEOqBf3YAAAAAAAA=


--=-OeR6bRPux76fm7jBAgkh--
