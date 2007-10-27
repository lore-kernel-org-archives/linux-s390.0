From: Roel Kluin <12o3l@tiscali.nl>
Date: Sat, 27 Oct 2007 11:39:39 +0000
Subject: Re: [PATCH] Fix priority mistakes in drivers/s390/cio/cmf.c
Message-Id: <4723237B.4090206@tiscali.nl>
In-Reply-To: <20071027081942.GA8163@osiris.boeblingen.de.ibm.com>
References: <20071027081942.GA8163@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Heiko Carstens wrote:

> 
> Applied to our tree. Thanks! How did you find that one?
> 

a="A-Za-z0-9_"
git-grep "\![^$a()]*[$a]\+\([$a.]*\|->\)*\(\[[$a.]*\]\)\?[ \W]*&[^&]\+"

cheers,

Roel
