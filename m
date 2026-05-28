Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048B286419;
	Thu, 28 May 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988007; cv=none; b=tRjmbjXBoIRsj/Y0GIqDutTpfiEQ6FL7DybXUzACuNv8szLincqhem41OdB/DJRIbjiw/VNrP4jys03IrrfSD+YXqWlWzjcjKPU0otZgRXcuMPhXP7HashiFpuVwOxuQEgEHuXdu0oPG7WDNVZKfNTeSJ+QtkK8ErU82l8WoAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988007; c=relaxed/simple;
	bh=41/dLmJEH2sC0di1SbQ7jYTvOMQix98VFMRgefRq7e4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqdctE7dbYCgZ1VSpPTWHbziLNFCQsltS74vmcaIAbGkxSjwnk7fsCuhFrAQf/600r7jjzipM/UqPW6ypVv9i4/B7Lwp8FHjyeJ3BTDcOxX4SbaoAjDwtntoGnbCYS/qPqNK3yvTQninHjLRFGN+M58VJJMDz4+tedmKO7zqYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N1QN1Q4w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N1QN1Q4w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TOTMrnfyoy+juETvupFXdLQQUWoKyuhVKkkJrB66tQs=; b=N1QN1Q4wsNgEXYJ6obuHLI0eMy
	WZjLQxRn49NiO45HN2eQ5pD6f2kCp9K46WgANuxnDKJiYxQU7yIL8v2QgyjbEkq+RZRyidAF/2tVY
	EZ+nPsH0WwjI8IcPP5dfve1FjPavKcxcasMuFpxP/3RbwiPcoYfP6xeEFs/vgnV9DDcJXL2DSTbNk
	8vCWvZXZSbATDEhMo/rhzajX660ALHDpqBtkGjCqBT2FoGLWYPyVjjgzqMG3JaTwOwEzmkRAoOOh/
	wtC9JZ+4MfQ5xdAALLpMIDseCzPWcUeYXJ9GUkmY8S7q+jGq0wbFARFWoB+XtKBoV5bxeb0Vsguxj
	L8rhzBHA==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=edge-cache-150.e-ind6.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeBm-00000004YVe-0zdi;
	Thu, 28 May 2026 17:06:34 +0000
Message-ID: <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
From: David Woodhouse <dwmw2@infradead.org>
To: Wen Gu <guwen@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>
Cc: tglx@kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jstultz@google.com, 
 anna-maria@linutronix.de, frederic@kernel.org, daniel.lezcano@kernel.org, 
 sboyd@kernel.org, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com,  jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,  svens@linux.ibm.com,
 nick.shi@broadcom.com, ajay.kaher@broadcom.com, 
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 linux-fpga@vger.kernel.org, imx@lists.linux.dev,
 linux-s390@vger.kernel.org,  dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org,  imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Date: Thu, 28 May 2026 18:06:32 +0100
In-Reply-To: <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
	 <20260407104802.34429-3-guwen@linux.alibaba.com>
	 <20260412084704.743482ad@kernel.org>
	 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
	 <20260412095301.4fe1fe65@kernel.org>
	 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-Hz9IYXkICHkbRU6bPLDM"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-Hz9IYXkICHkbRU6bPLDM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-13 at 17:00 +0800, Wen Gu wrote:
>=20
> On 2026/4/13 00:53, Jakub Kicinski wrote:
> > On Sun, 12 Apr 2026 17:32:22 +0100 David Woodhouse wrote:
> > > On 12 April 2026 16:47:04 BST, Jakub Kicinski <kuba@kernel.org> wrote=
:
> > > > On Tue,=C2=A0 7 Apr 2026 18:48:02 +0800 Wen Gu wrote:
> > > > > +PTP EMULATED CLOCK SUPPORT
> > > > > +M:	David Woodhouse <dwmw2@infradead.org>
> > > > > +M:	Wen Gu <guwen@linux.alibaba.com>
> > > > > +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > +L:	linux-kernel@vger.kernel.org
> > > > > +S:	Maintained
> > > > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git=
 timers/core
> > > >=20
> > > > Hi David,
> > > >=20
> > > > Do you have a tree to route the patches thru? Or do you really have
> > > > access to the tip tree?
> > >=20
> > > I do not have access to the tip tree. I can make a shared tree on
> > > git.infradead.org if the other two maintainers would like to send me
> > > a SSH pubkey and preferred username...
> >=20
> > Honestly I'd love for you to be the only M here, and the other two
> > to be reviewers. Xuan Zhuo is currently at v40 trying to upstream
> > an Ethernet driver. Some growth needed there to become a subsystem
> > maintainer IMO.
>=20
> Hi Jakub, David,
>=20
> That works for us. We can act as reviewers.
>=20
> If David sets up a new tree, I will update the MAINTAINERS entry
> accordingly in v3.

Apologies for the delay. I have set up

https://git.infradead.org/?p=3Dlinux-ptp.git
git://git.infradead.org/linux-ptp.git

But I'm not keen on using it without Richard's explicit approval and a
clear understanding of who owns what, *and* the taxonomy we use...

I'm not entirely keen on 'emulated' as the directory name. I don't want
to get too bogged down in bikeshedding, and I know we've done some
already, but I think 'virt' is a better fit? Although when I get my
hands on one of those PTM-capable TimeCards, vmclock won't *just* be
virt... :)

I'm not sure I agree that the drivers being left behind in drivers/ptp
are "IEEE1588 / network-oriented clock drivers" as the commit message
of patch 1 suggests, either. The only one that goes anywhere *near* a
network is ptp_ines.c which has a mii_timestamper interface.

Apart from that they are *all* just PHC clock drivers, aren't they? The
actual network ones live in drivers/net.

So maybe the better answer is to have a more conventional core/drivers
split? Except maybe for ptp_ines is there anything that *network*
maintainers care about, other than the core?

If we do that, add an X: line to exclude the drivers subdir from the
network section in MAINTAINERS, and leave all of drivers/ptp owned by
Richard as it is... do we *need* a new tree?=20

--=-Hz9IYXkICHkbRU6bPLDM
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyODE3MDYz
MlowLwYJKoZIhvcNAQkEMSIEIK1wfg9Fv2luMSVmR4Kx1ejNVAjdacEO1ogP0pQoCY3fMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAH45zq4alGUdn
hAUUUKytj4LXIU7vYtQvgpOvHi9oAjEILkhhdss7za+Yo7PIxrDkiHJwpwBB4Ks/eFrk90YghRA+
6UlmiVmGhT688ZQQpDeWGMvK4TqBNJLfKIWuuC86h30ctsBpPYqDsv7zS43t7x6V07ZcuTg5T16s
4BDJeqG90RrD0lXqlsTKba5e3WOtr/n1+NnrGawFFm4TauGtL6JR9dlrO0ej2CUdOHk7nzjVWxD+
coB+/EYZFWrp8owD1buQKEEdFIm/RsK7qQznkfjO/WePLn3/w7DoyBIbkezP7zQcq4cC+Jcj0PQq
RGFivOUdICXSE2wsDXm+Jx3d6YB3xDeCSCvEsW2DR1z3N0q1wwyIgdZz3r5UahMbMFuObYudqFa6
NSS0yNQ269jZLJEwYAICe3kQLCfPPAEIq9yNXxef9Es0F0ji8NXnQrIKIGXJjy7QCHAmWky0SFxu
WqVyo7SiLMfFNR741y8rHV+HbDD5/YojF1JTVHyLCSOL/6InEKZYRENHUokMU6jC7qU4xlG8aFv+
RI69lDGwcmmJGM7bndCHvmOSMMAoFQBGxkn9xyIlOKNeE15blBRS0Hm+iGqsIJNmlbgFPgMy/3q0
JJ/o19zxb4RkyKsdNxd92s1PgAJ1BXoyE2jS6uDRQdkwWOhpyroF4CaF6AAgr3gAAAAAAAA=


--=-Hz9IYXkICHkbRU6bPLDM--
