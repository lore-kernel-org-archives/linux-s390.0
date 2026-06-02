Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34E3F7891;
	Tue,  2 Jun 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420540; cv=none; b=NzIsJ6Uiq7brsVW315ZSXBg4gzuv3shaSb6XkZ9vMI2Iie345gVw7tqt25Pm2qhuffnco0V2fLYLEENyxd3XRjV8dAoqZnGXseFehBpfy7B43PiKB38EtcgnPSwNEimd/VP14xdLg/zweONXUsWsUMUrCwvX1nAuYkPUpaFE6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420540; c=relaxed/simple;
	bh=kkyXPebYwJ/UpauPaOt24fg6+WUOD4Y08/xBiZarvsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6lDQeDpF51/cL/UfrUot+mbHaIQim0kt38esH0rEKFx9Iyc/x4HlMv/d7t8Cq0W6Ruf1a2LtIIvgjRs0j85+Mow2EH96cq6mOzxCrxwzCnuMug3Ryqgs1J7bKxzv02tagPMU0qLaVoevSoP6NiXwdkklXGlb9jMuk3+NAKvxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lGAMQcp1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lGAMQcp1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kkyXPebYwJ/UpauPaOt24fg6+WUOD4Y08/xBiZarvsY=; b=lGAMQcp1U6l4eDLhRrdmc+i+hK
	+ykaJocmPqWV//dQk9GAoty1ZemGnXbTg16FLKBPlb155JpUD1l6wAniJ7Ozjc255EnI/cgQgNpDv
	UjUUTmEEac9PmqABeWHGcK9SFBPqgO7GlqmtqYpNTlh1ZprBIHAhL9DRemdKL19Olpdvs/WOmre/7
	WoH23nY0KAaQKL0I3bVkZ+9AvdfUBxb833nUrEQnr1ZsNXXIo+rvEiL8bvNx7b6QcTZqxl/P6Qz2r
	Vgpgyn6PVj8hWYwDZrQljmiqqE5Eu2EhT/z4KoKBKJZsZxvAuFrc1DQ0twHmEm3I/7UopLyC5ub18
	xdHfrh7A==;
Received: from [2001:8b0:10b:5:c68:987:fac8:ab00] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSi7-00000002KiL-3HEV;
	Tue, 02 Jun 2026 17:15:28 +0000
Message-ID: <27ff3ab8ea24a80812c54d18a18bda65acce5c08.camel@infradead.org>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
From: David Woodhouse <dwmw2@infradead.org>
To: Wen Gu <guwen@linux.alibaba.com>, Richard Cochran
 <richardcochran@gmail.com>,  Jakub Kicinski <kuba@kernel.org>
Cc: tglx@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, jstultz@google.com, anna-maria@linutronix.de, 
 frederic@kernel.org, daniel.lezcano@kernel.org, sboyd@kernel.org, 
 vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com, 
 jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, 
 svens@linux.ibm.com, nick.shi@broadcom.com, ajay.kaher@broadcom.com, 
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 linux-fpga@vger.kernel.org, imx@lists.linux.dev,
 linux-s390@vger.kernel.org,  dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org,  imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Date: Tue, 02 Jun 2026 18:15:27 +0100
In-Reply-To: <335ae01a-20aa-439e-996c-d35ffd8d476a@linux.alibaba.com>
References: <20260412084704.743482ad@kernel.org>
	 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
	 <20260412095301.4fe1fe65@kernel.org>
	 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
	 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
	 <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
	 <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
	 <ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
	 <0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
	 <20260601185226.7f43fa75@kernel.org> <ah5aGMIxA418sxoj@hoboy.vegasvil.org>
	 <0b3f00bbfa6bcc3badb4d1bb7845326e2dbaa1d4.camel@infradead.org>
	 <335ae01a-20aa-439e-996c-d35ffd8d476a@linux.alibaba.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-bFbDCAYFbExy0zXwkgt3"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-bFbDCAYFbExy0zXwkgt3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-02 at 22:03 +0800, Wen Gu wrote:
>=20
> > There is some extra stuff we want to do for "Precision RTCs" or
> > whatever we're going to call them. They might actually have a known TAI
> > offset, they might convey leap second indications, we might want to set
> > the kernel's CLOCK_REALTIME from them at boot. And in the case of
> > VMClock, I'm working on being able to clamp the kernel's timekeeping to
> > it directly=C2=B2.
> >=20
> > So maybe what we want is linux/drivers/phc, to host those read-only
> > devices which know real time. They can provide a simplified
> > implementation; maybe *only* a function like vmclock_get_crosststamp(),
> > which is just called in various different permutations by the various
> > different PTP methods.
> >=20
> > The core linux/drivers/phc code would then handle the interface to the
> > kernel's core timekeeping *and* wrap them to register a PTP device that
> > existing userspace can understand. And deal with the kvmclock/TSC
> > awfulness where needed.
> >=20
> > How does that sound?
> >=20
>=20
> I think a dedicated phc core would make the classification of read-only
> clocks clearer, reducing ambiguity around where they belong. I assume
> direct timekeeping integration would be optional, drivers providing
> only a snapshot-based crosststamp would use /dev/ptpX alone, while the
> timekeeping path would require additional capability (as vmclock provides=
)?

Yeah. I think they might all want to be able to opt in to setting the
time at boot? But actually setting the fine-tuning of the kernel's
timekeeper is probably only something vmclock can do.

--=-bFbDCAYFbExy0zXwkgt3
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwMjE3MTUy
N1owLwYJKoZIhvcNAQkEMSIEIBCzzc7M9R7ddx72OwI8EXMtb635v7dJ3qKQmvnHX0+hMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAh4su4NqXBBAL
aHTsW7EyeMpcQRMKb78TuM8WAk4NkPvx5dJsOhzEzV/DMj6XIaynKDsZjRvSKAugiT6y/dhEDwuf
kVSaRvyzH/QWgwP4lKocnAiiY7vnqwcXzw2TUvGdpJVXeb2vDjvHdXTiAB53vlkdPx+CtSfPQ2/n
0LEK1pen8t0BTAUcvaWq5b2en27Y02adLqunPwqzurr2f01ZmtxwF0PBfJ93VovKZ81Wcy4f0I8a
syAxTNAJJl6ZBZ6G680kTBBWPLdZiTqVC+QTyMryvYddsdr1nX+YhstkFzVh40IYOkqhkYOOVYTk
crncW3h2E+WTC2bSnS+N4VDbWHv1TWvdMCb+CG4zH5BPqGgA81K7yKs36G5Eq3AhxIFHczmOgck7
zhvdm8oVW0lva+gPovaLxH/Ld3vw3xt5LCt1Lzti1JtLBIhnE8XB5bHsOZpwaXOJPPnicctM1Yxm
4fZwt4z7AWX6VdN0LW0gyL5Cd13IMkv5f0cT0ewoUivofe9Lqc4dmATKwW1Ta0JonFbW/MUq3YcN
0CrfrQ6X5y4ulbNZSFTPYw48B1WyiqD402+OrCyC2KqObRgi9Sv3frPTFufPSpEcEQLiAqsUu7o4
Tnprnrk4mrHDw2Xj8PdXkF3en4sHyIwXLF6mXoxC7HxWRvPA0etzTwL98zAz9f0AAAAAAAA=


--=-bFbDCAYFbExy0zXwkgt3--
