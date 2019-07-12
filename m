Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:59978 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfGLUTX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 16:19:23 -0400
Date: Fri, 12 Jul 2019 14:19:21 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/5] PDF output fixes
Message-ID: <20190712141921.7f8a1d02@lwn.net>
In-Reply-To: <cover.1562696797.git.mchehab+samsung@kernel.org>
References: <cover.1562696797.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hannes Reinecke <hare@suse.com>, linux-kbuild@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Michal Marek <michal.lkml@markovi.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, Omar Sandoval <osandov@fb.com>

On Tue,  9 Jul 2019 15:33:18 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> In order to be able to build all PDF books, besides the two patches I
> already sent:
> 
>     docs: pdf: add all Documentation/*/index.rst to PDF output
>     docs: automarkup.py: ignore exceptions when seeking for xrefs
> 
> A few others are needed:
> 
> - patch 1 removes nested tables for a few files I converted, as 
>   Sphinx LaTeX builder doesn't support it;
> - Patches 2 to 4 addresses some minor issues on some books,
>   usually requiring some blank lines, extra whitespaces or some
>   tag replacement;
> - Patch 5 is required in order to be able to build the translations
>   PDF book, as it adds Asian fonts support to XeLaTeX.

So, modulo my one comment on the last patch the series seems OK, though I
don't like having to work around limitations in PDF generation this way.
Can't you just make rst2pdf work instead? :)

I guess it makes sense for these to go with the big band-aid-removal patch
set.

Thanks,

jon

P.S. it seems that rst2pdf is actually being developed again:
https://akrabat.com/rst2pdf-back-from-the-dead/ .  I wonder how far
they'll get with it.
