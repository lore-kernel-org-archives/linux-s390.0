Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727730AbfGRMvu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 08:51:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IClnAZ040817
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 08:51:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttq5qmw5p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 08:51:48 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 18 Jul 2019 13:51:36 +0100
Date: Thu, 18 Jul 2019 14:50:44 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Is __dma_direct_alloc_pages broken on s390?
In-Reply-To: <20190718135112.5c65685f@ezekiel.suse.cz>
References: <20190718091700.353b3721@ezekiel.suse.cz>
        <20190718113633.GB3581@osiris>
        <20190718135112.5c65685f@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/x1HKbcEIccBKcCKkIMZI6bj"; protocol="application/pgp-signature"
Message-Id: <20190718145044.03dc9804.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>

--Sig_/x1HKbcEIccBKcCKkIMZI6bj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2019 13:51:12 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> On Thu, 18 Jul 2019 13:36:33 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>=20
> > On Thu, Jul 18, 2019 at 09:17:00AM +0200, Petr Tesarik wrote:
> > > Hi all,
> > >=20
> > > while looking into DMA allocation, I noticed that
> > > __dma_direct_optimal_gfp_mask() in kernel/dma/direct.c can probably be
> > > improved. It uses GFP_DMA if dev->coherent_dma_mask is less than
> > > DMA_BIT_MASK(ARCH_ZONE_DMA_BITS). There is no s390-specific definition
> > > of ARCH_ZONE_DMA_BITS. The default is 24 bits, but the DMA zone on s3=
90
> > > is 31 bits. CCW subchannel devices set sch->dev.coherent_dma_mask to
> > > DMA_BIT_MASK(31), which is greater than DMA_BIT_MASK(24), so buffers
> > > are allocated from the Normal zone first.
> > >=20
> > > Would it make sense to set ARCH_ZONE_BITS to 31 on s390, or did I miss
> > > something? =20
> >=20
> > No, this seems to be broken. Halil, can you look into this and provide
> > a patch?
>=20
> I wondered why the kernel works OK on my system, and it is in fact not
> so bad. If the first allocation fails, the kernel adds GFP_DMA and
> retries, so this is not fatal, but with a proper definition of
> ARCH_ZONE_DMA_BITS it should be possible to get success in the first
> attempt already, let's do it.
>=20
> Petr T

I fully agree! I will post a patch that provides correct
ARCH_ZONE_DMA_BITS for s390.

BTW I wonder if ARCH_ZONE_DMA_BITS can be inferred from MAX_DMA_ADDRESS,
and why do we need both.@Christoph, maybe you can help me understand if
there is a relationship between the two or not, or?

Regards,
Halil

--Sig_/x1HKbcEIccBKcCKkIMZI6bj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJdMGtUAAoJEA0vhuyXGx0AQwwP/R4sy2hwEQLANa+ywTiy+bNo
6VGQoStNJDhieDfK1zv+zbUBsfXtHx4bBlzguVQSRnptlu15uyR9FF6c0MXtlotC
HK3J39O5mIv/mR5rVYolO2C4CW4bil9aDYQPjlmlYT7INrlAPs5+JShw252B15Qu
94lhs29WuqV1ljTO7FsbQVcAe8RwhvF2Rn4aE9btaW4TXbqZgce4qtiDeHBfnSC1
rhIf2YRoCbDj9Aywp82NFgjQzBnZLY1OQekRTNBL94ZP5kVc7QB+wSHR4yNW3rXh
CzV+MNm+CRJGQEt7hCaNMNH+9vuyqb0He+UtiRZgFEcxxyIudF6CU7C59OCRpT8F
E5eWXdyaV7NCra7SfI1ksK/3DDt0SSIRwZz6lWcCq/qkeQ8bwaU2D+kBVpZenv7I
kmiGGrQdUdPMLEEKDQwccxEqTdr77wMdIjFdAY8nsuMeBx1Ij57jCfmfBFLOKcI8
mNPnBMde6JrCn2Cp8+jKVRvXliM5+SgjifXhaMkCPMfsJ8anQYJGjhDWOlxmBzcX
cQKtJyqizNi23aS2c76lDbLUBTAGj4Hw+exBdv7iDqIkCecRTpJLlMClPIeaNDzh
JnYkorz6vIXKB+/LH0Yvyv1+Zxr09mcYq/32mNK5QkuOVDXcPhNrFnXQixvhgJE+
47lzIQHxRC4aF5VcTNN0
=Ogat
-----END PGP SIGNATURE-----

--Sig_/x1HKbcEIccBKcCKkIMZI6bj--
