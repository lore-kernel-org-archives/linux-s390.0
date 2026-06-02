Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5E3C0A1B;
	Tue,  2 Jun 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387487; cv=none; b=kkZ2vIvfDkki6dDbpQCVnuc4lcd7Sg0Ps1H4KFpBg4PrT1ZMwRqRX1q4NWQglPKoDqfCrkTisKF8x3C5LsPWX3u81iYuqbWKKlFIIsW0OjXstYMJB73U8sSFtPemQVfkC2ww6kAmJEfCSUdiliPxZAFcMNBmkwQFvx5UUvAR5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387487; c=relaxed/simple;
	bh=f4u9eepWT9EhiP3VPEm3hQVTwZ2X4AC4lmvrh96dahY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWiGWwEZ8rrYg+UyZIRysxwzBu0DNQcnkLkcjuhGkJ44ADHcXItMhl/WT7WtyVcwYAbsvdjFMFZSkQpzrYJkncSsHpkiX8o2WQ6s7Q7iu52qf6HcRRCVR6kpO7gpE84GW+EQ72RTEJU41xydS/eiTiiDLLx4ukyhrrCVd3VKoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oTehBGre; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oTehBGre"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f4u9eepWT9EhiP3VPEm3hQVTwZ2X4AC4lmvrh96dahY=; b=oTehBGreEofBqSsOK74pBu8aZZ
	Zt2Lq86bNImr0qcS+eg1kN2zXBRfcQVAJ4ksZtpgkYRAmYnk06/qNQjzBGFhHcgkH2yTyH8HpRHB+
	sLV6WsyZjkdrmKp7PaoBqWt4yuLi+tN+MaRL9WYhDk8xOcK7kahHJUZM8FX5ZCmCUirvfTm5hKdrY
	zZwojafRxk0ZsLN927/mu8UyU9dch1xSYvZbnTjmfCWNQHxwXnucJz6Mr9pWo+k7KEhpPxjDGH45W
	+1yK0skFCXEsa/ofHlpVTFeG4EjFBQQylSF6fYFLZ61Rbn4Ciyk1rICWE0eAI3BsXO9Md4lAjpiRA
	ZIYtlvBA==;
Received: from [2001:8b0:10b:5:5b40:b57d:669c:36f4] (helo=2001-08b0-010b-0005-5b40-b57d-669c-36f4.ip6.reverse-dns.uk)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUK6t-00000001ZaP-2w49;
	Tue, 02 Jun 2026 08:04:28 +0000
Message-ID: <0b3f00bbfa6bcc3badb4d1bb7845326e2dbaa1d4.camel@infradead.org>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
From: David Woodhouse <dwmw2@infradead.org>
To: Richard Cochran <richardcochran@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, tglx@kernel.org,
 andrew+netdev@lunn.ch,  davem@davemloft.net, edumazet@google.com,
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
Date: Tue, 02 Jun 2026 09:04:27 +0100
In-Reply-To: <ah5aGMIxA418sxoj@hoboy.vegasvil.org>
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
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-RP0sFoYLKy91Bkl5IsXb"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-RP0sFoYLKy91Bkl5IsXb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 21:20 -0700, Richard Cochran wrote:
>=20
> Sorry for replying to David here via Jakub's message.=C2=A0 Somehow my
> brilliant Gmail doesn't have David's reply...

Yeah, Gmail. Here's a nickel, kid... :)

> On Mon, Jun 01, 2026 at 06:52:26PM -0700, Jakub Kicinski wrote:
> > On Mon, 01 Jun 2026 17:53:49 +0100 David Woodhouse wrote:
> > > On Mon, 2026-06-01 at 08:20 -0700, Richard Cochran wrote:
> > > > Sorry, just catching up here, so the idea is to have
> > > >=20
> > > > =C2=A0linux/drivers/ptp/drivers=C2=A0 ?=C2=A0=20
> > >=20
> > > That is my current suggestion.
>=20
> drivers/../drivers seems a bit silly to me

It wouldn't be the first, but yeah =E2=80=94 more conventional would be to =
have
the core elsewhere and the drivers under linux/drivers/.=20

That maybe involves moving the PTP core to kernel/time/ptp[/*] while
leaving the drivers where they are?

But first we have to know the problem we're trying to solve, and Jakub
has just revised my understanding of what he was originally asking for.

> > > It stems from Jakub's response in
> > > https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/=C2=A0=
that "I
> > > really wish someone stepped up and created a separate subsystem for a=
ll
> > > these cloud / vm clocks. They have nothing to do with PTP."
> > >=20
> > > There was some further bikeshedding in
> > > https://lore.kernel.org/netdev/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@l=
inux.alibaba.com/
>=20
> The idea of categorizing core, NIC-related, vm, and stand alone clock
> devices makes some sense to me.
>=20
> > > around how to split 'emulated' from other hardware drivers, but I don=
't
> > > much like that taxonomy. Some of these "virtual" clocks could just as
> > > easily exist in hardware with PTM too.
>=20
> So the whole in-kernel API in ptp_clock_kernel.h with ptp_clock_info,
> etc, was poorly named (by me) back around Linux 3.0.=C2=A0 After all, the
> abbreviation, "PTP", stands for a network protocol.=C2=A0 At the time, Al=
an
> Cox pointed that out and complained, but somehow the code got merged
> anyhow.
>=20
> The term PHC is a better one, since PTP Hardware Clock means clock
> device whose purpose is to support network time keeping together with
> a NIC.
>=20
> > > My observation is that with the sole exception of ptp_inet.c, *all* o=
f
> > > the actual PHC drivers that live in drivers/ptp instead of drivers/ne=
t
> > > are "pure clock" drivers,
>=20
> No, that is not quite right.=C2=A0 The clockmatrix, idt82p33, ines, and
> qoriq drivers wouldn't be very useful without an attached NIC.

Ah, OK. Moderately confused because ines is the only one where I see
any evidence of hwtstamp support, and the rest just seem to provide a
PHC, but I'll take your word for it.

> > > so perhaps we split those all out into
> > > drivers/ptp/drivers/ and exclude them from the netdev maintenance?
>=20
> Originally the idea was that the rate of patches would be low enough
> that netdev would be the place to post and review them, and that no
> separate tree or mailing list were needed.=20

I think that assumption about the rate of patches should still be true.
If I end up owning a tree for the 'virt' drivers, I'd mostly be
answering "no, use VMClock instead". There's a reason I found a home
for that as a vendor-agnostic specification=C2=B9 and built the QEMU and
guest kernel support before even pushing it out at $DAYJOB.

=C2=B9 https://uapi-group.org/specifications/specs/vmclock/

> Even though the "PTP" naming was an unfortunate choice way back when,
> still I'm not a big fan of moving stuff around "just because".
>=20
> But moving forward, I would suggest starting a new area for pure
> hardware clock devices.=C2=A0=20

I think that ties relatively well to Jakub's "does it purport to know
real time better than the host" criterion?

Although... ENA *both* purports to know real time better than the host
*and* does packet timestamping, and it looks like GVE is attempting to
do the same?

> =C2=A0=C2=A0 "Clock Devices" ?
> =C2=A0=C2=A0 linux/drivers/cd
>=20
> Too short!
>=20
> =C2=A0=C2=A0 "Time Keeping Devices" ?
> =C2=A0=C2=A0 linux/drivers/tkd
>=20
> Confuses core time keeping!

That isn't necessarily a bad thing... (qv)

> =C2=A0=C2=A0 "Advanced Clock Devices" ?
> =C2=A0=C2=A0 linux/drivers/acd
>=20
> Let's come up with a fitting name.
>=20
> Still, I don't understand why these new (non-network related ) device
> drivers can't be implemented in their own class using
> posix_clock_register()
> etc.
>=20
> Any of the useful bits (like sysfs interfaces) can be refactored out
> of ptp_clock.c and shared as a common layer.

The key is that userspace wants to get snapshots of the reference clock
either precisely synchronized with the system clock where possible, or
sandwiched as closely together as possible with ABA readings of the
system, reference, system clock.

Those *are* the PTP_SYS_OFFSET* ioctls, which tools like chrony already
support with 'refclock PHC /dev/ptp=E2=80=A6'.

I'm not sure how factoring those out into separate POSIX AUX clocks
would help? I think they do want to present as /dev/ptp*.

There is some extra stuff we want to do for "Precision RTCs" or
whatever we're going to call them. They might actually have a known TAI
offset, they might convey leap second indications, we might want to set
the kernel's CLOCK_REALTIME from them at boot. And in the case of
VMClock, I'm working on being able to clamp the kernel's timekeeping to
it directly=C2=B2.

So maybe what we want is linux/drivers/phc, to host those read-only
devices which know real time. They can provide a simplified
implementation; maybe *only* a function like vmclock_get_crosststamp(),
which is just called in various different permutations by the various
different PTP methods.

The core linux/drivers/phc code would then handle the interface to the
kernel's core timekeeping *and* wrap them to register a PTP device that
existing userspace can understand. And deal with the kvmclock/TSC
awfulness where needed.

How does that sound?=20


=C2=B2 https://lore.kernel.org/all/20260520135207.37826-9-dwmw2@infradead.o=
rg/






--=-RP0sFoYLKy91Bkl5IsXb
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwMjA4MDQy
N1owLwYJKoZIhvcNAQkEMSIEIIGcKIP2EPstYmZEUerRVfVfjJLflCgkwLcbjoG2nZCKMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIArByzGoa3JuPd
rSLvIUVRy+Iu1AI3hFh/pZm5GW7hstctYsHMnVPBgy/L1X5g/Edz1/ylEMrftxsfTi8ctXwR5YoN
BsAdVa+4imGrX+700zm/iLtUXqFPSxJ5H/RbKmioqqf3poQLHJIjHlzW9S6wZRaQOLjOctQwUC+8
umC4SdZ5YyoM6NiFEtEtui5GemWcflX1ALtSE5Mtk2qCP1DOuFBOsciSjj8TU7ItjnHAmyInzsUk
VdiFKdix0a9DbKR6bMyOFelC2Yh7TNlY4jgb1EWTMvEQTRl3vmMq0nv0JU+idUPrOtxq3GYouNGt
OwngMK4h+Jg5alOEHCOiYXWsTbv5c+vZHxdENMttm/tWKGyfRtRtWKHSmBYtVUymkTm1jd84o12a
uC2U5AEYyQcO6AvwitBt/KO30xi5ZJUzBbNOjz60nKO8hqaxqnVW1I28bmg737hIb1ItxiomgfDI
NERZbsZEBBL5dIyAF1WK35KSVwhG8lcmMJX88PSE8+ajFQGZnWI7NVyn0LO8nSFtGBjA0JGxUnzC
4l51keV8bgXIRF8xq4pFJ35zo6gp58BDbhqDCg18RpHx/3jDphJqSwUkSWYb42H8O9nzHJYJfBN2
/guiO/bKQA8H7jjYVYyg2EbFTB7905J7i+mGZ/iurGTuPKQqBtZ1cNR58uw0QRQAAAAAAAA=


--=-RP0sFoYLKy91Bkl5IsXb--
