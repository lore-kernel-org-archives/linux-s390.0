From: Jiri Slaby <jslaby@suse.cz>
Date: Tue, 06 Jan 2015 14:02:47 +0000
Subject: Re: [stable] 3215 fixes for 3.16 and earlier
Message-Id: <54ABEB07.8030603@suse.cz>
In-Reply-To: <20150105104510.GB2388@charon>
References: <20150105104510.GB2388@charon>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 12/29/2014, 07:54 PM, Ben Hutchings wrote:
> I cherry-picked these commits from 3.17 for Debian's 3.16 branch,
> but they should also apply to some earlier versions:

Thanks, now applied to 3.12.

> commit 26d766c60f4ea08cd14f0f3435a6db3d6cc2ae96 Author: Martin
> Schwidefsky <schwidefsky@de.ibm.com> Date:   Tue Jul 15 17:53:12
> 2014 +0200
> 
> s390/3215: fix hanging console issue [Stephen reported this against
> 3.10 initially]
> 
> commit e512d56c799517f33b301d81e9a5e0ebf30c2d1e Author: Martin
> Schwidefsky <schwidefsky@de.ibm.com> Date:   Wed Aug 13 12:01:30
> 2014 +0200
> 
> s390/3215: fix tty output containing tabs [the commit message
> mentions a regression in 2.6.31]
> 
> Ben.
> 


- -- 
js
suse labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUq+sBAAoJEL0lsQQGtHBJ/F8QAIpbbxzvAkmInoz1fM66qZEN
ABAmCqWq9NPTxhTLJ3lLSkTB7+Un9zWjF31CbuIXoATxPRKKou4LK5ibYgBwZ38I
38DBMLFWXCEnXIQPc3rbKfh4emCojBwnQpTrG6igtuYARRSzPnTsJV2qJn2flDRN
aMBWb9zrS4pK8uZRA6fCqQPFr90mQILm326ikA5il7XXYhEUMnMFhHEWrOO5CeD8
gj2+706gcoUCrifMlYsbNqewVG8tuD68TkzHxS50J90wmWwA+Y5jpCAzeby84hcz
x2YMp0fcygWq3vfPmqDckjcmOvrj8+xQ3HxDkZrkmyjoKrLl6j3Lp/1Rj4EvsB/x
pP3erELjYrB9KrRPwjUzKFqWhv5Tard9e/A14SQk9WPEveXZynoefPCmPqwgWFcN
ESNvb0G22SNwdWCatJaf+cZk1e9N8yH8Bkt60AFbwfA4bB+OewD2h8CkDNZR7/qJ
Rseib3kQjHvihYM6llYOdyN5N5bCJwaG3anSJpNLmWBhXsk4JOzXFG0lJeT4++p1
H9JPRAAXrg5E11wmxU9SKyyt2Of6/9wxZqBpCX3mESUQrVHSeafxviCPsFe1mVR2
7j8n1tVRBh9YYrn+iHhWSPKZt5cmuFIcDenEPL/9SNeebSIieF3DfR2TXimGvpW5
e3aqJ1RVRI5pzBTyGILd
=5sCZ
-----END PGP SIGNATURE-----
