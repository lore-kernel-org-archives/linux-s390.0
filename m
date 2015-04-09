From: Zefan Li <lizefan@huawei.com>
Date: Thu, 09 Apr 2015 01:26:08 +0000
Subject: Re: [stable] 3215 fixes for 3.16 and earlier
Message-Id: <5525D530.409@huawei.com>
In-Reply-To: <54ABEB07.8030603@suse.cz>
References: <54ABEB07.8030603@suse.cz>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2014/12/30 2:54, Ben Hutchings wrote:
> I cherry-picked these commits from 3.17 for Debian's 3.16 branch, but
> they should also apply to some earlier versions:
> 
> commit 26d766c60f4ea08cd14f0f3435a6db3d6cc2ae96
> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date:   Tue Jul 15 17:53:12 2014 +0200
> 
>     s390/3215: fix hanging console issue
> [Stephen reported this against 3.10 initially]
> 
> commit e512d56c799517f33b301d81e9a5e0ebf30c2d1e
> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date:   Wed Aug 13 12:01:30 2014 +0200
> 
>     s390/3215: fix tty output containing tabs
> [the commit message mentions a regression in 2.6.31]
> 

I've added the second one to 3.4. Thanks!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlUl1TAACgkQWyV2+h1UztN0uQCgvvao9w4wibhzQ4Qn2x3QPsJh
QREAoMXBDKFBTHI1IbZ9BwU98ftS7A2z
=jxdO
-----END PGP SIGNATURE-----
