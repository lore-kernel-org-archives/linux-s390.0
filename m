Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgAIBKl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Jan 2020 20:10:41 -0500
Date: Thu, 9 Jan 2020 02:10:25 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware
 compression
Message-ID: <20200109011025.GM3929@suse.cz>
Reply-To: dsterba@suse.cz
References: <20200107143058.GU3929@twin.jikos.cz>
 <20200108105103.29028-1-zaslonko@linux.ibm.com>
 <75a2d45c-fd7b-9542-403d-caea7d977add@toxicpanda.com>
 <94e06859-6174-c80d-3eb6-065f67fbe95d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <94e06859-6174-c80d-3eb6-065f67fbe95d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 07:48:31PM +0100, Zaslonko Mikhail wrote:
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD } els=
e if (workspace->strm.avail_out =3D=3D 0) {
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD /* get another page for the stream end */
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD kunmap(out_page);
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD if (nr_pages =3D=3D nr_dest_pages) {
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD out_page=
 =3D NULL;
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D =
-E2BIG;
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD goto out;
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD out_page =3D alloc_page(GFP_NOFS | __GFP_HIG=
HMEM);
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD if (out_page =3D=3D NULL) {
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D =
-ENOMEM;
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD goto out;
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> >=20
> > Do we need zlib_deflateEnd() for the above error cases?=EF=BF=BD Thanks,
>=20
> The original btrfs code did not call zlib_deflateEnd() for -E2BIG and=20
> -ENOMEM cases, so I stick to the same logic.
> Unlike userspace zlib where deflateEnd() frees all dynamically allocated =

> memory, in the kernel it doesn't do much apart from setting the return=20
> code (since all the memory allocations for kernel zlib are performed in a=
dvance).

Agreed, deflateEnd is not necessary in the error cases.
