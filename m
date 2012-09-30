From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [-next]: s390 *_irq() link errors
Date: Sun, 30 Sep 2012 11:20:52 +0200
Message-ID: <20120930112052.733ce361@endymion.delvare>
References: <CAMuHMdXqsPgfToNyjbxJ-WM=-kEEvAweE03wb3vtkwVO+-RR3A@mail.gmail.com>
	<20120927115134.GA5654@osiris.de.ibm.com>
	<CAMuHMdUqXnY5ZNgjYN0YMpLkPw0j41MXM18H9qiLoEk-BzKYMg@mail.gmail.com>
	<20120930105350.16e54037@endymion.delvare>
	<CAMuHMdV=mcVuVuJaWrVjwxLz0+gkBoC=NUq6=C176B3W7j8Yag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV=mcVuVuJaWrVjwxLz0+gkBoC=NUq6=C176B3W7j8Yag@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, linux-s390@vger.kernel.org, Linux-Next <linux-next@vger.kernel.org>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 30 Sep 2012 11:08:41 +0200, Geert Uytterhoeven wrote:
> On Sun, Sep 30, 2012 at 10:53 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > I thought we were trying to move away from explicit arch exclusions,
> > but if S390 is special then fine with me. I've folded Heiko's fix into
> 
> "depends on GENERIC_HARDIRQS" is the alternative...

That would make even less sense to me, I2C can work just fine without
IRQs.

-- 
Jean Delvare
