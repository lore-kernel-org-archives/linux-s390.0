From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v3 0/7] Remove errors building drivers/DRIVERNAME
Date: Thu, 4 Oct 2018 12:00:38 +1000 (AEST)
Message-ID: <alpine.LNX.2.21.1810041200240.8@nippy.intranet>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20181001075607.GA3776@rric.localdomain> <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com> <alpine.LNX.2.21.1810040915040.8@nippy.intranet>
 <CADvQ+rE8qQmSangHOCrJo7aAD-BJiN3Gt2hCi-3O8uRTgXnP-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADvQ+rE8qQmSangHOCrJo7aAD-BJiN3Gt2hCi-3O8uRTgXnP-w@mail.gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: Robert Richter <rric@kernel.org>, lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 3 Oct 2018, Leonardo Bras wrote:

> Both ccache and distcc seem very interesting, I will take my time to 
> study them better as they can solve some situations I face. Thanks for 
> sharing!
> 

You might also want to check out 'gcc -O0', 'gcc -fopt-info' and 'gcc 
--help=optimizers' etc to see if you can reduce the compute cost.

To reduce IO cost, my build tests always use 'make O=/some/path' where 
/some/path is on a tmpfs mountpoint.

HTH.

-- 
