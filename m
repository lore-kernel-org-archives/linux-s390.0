Return-Path: <linux-kernel-owner+w=401wt.eu-S1759775AbXJEIab@vger.kernel.org>
Subject: Re: [patch 00/34] s390 patches for 2.6.24
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20071004191015.GA23211@uranus.ravnborg.org>
References: <20071004112706.574737175@de.ibm.com>
	 <20071004191015.GA23211@uranus.ravnborg.org>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 10:30:17 +0200
Message-Id: <1191573017.18414.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2007-10-04 at 21:10 +0200, Sam Ravnborg wrote:
> Hi Martin.
> On Thu, Oct 04, 2007 at 01:27:06PM +0200, Martin Schwidefsky wrote:
> > The current set of s390 patches ready to be pushed once 2.6.23
> > has hit the streets.
> 
> I noticed that I had not yet beautified the vmlinux.lds file of s390.
> Please consider the next two patches for 2.6.24.
> 
> The first patch refactor vmlinux.lds to a consistent (and more readable)
> style that is being gradually introduced for all archs.
> Rationale behind a consistent style is to make across-all-archs
> changes less error prone and to better recongnize similar patterns.
> The patch moves a few labels so they get the correct value even if
> ld decide to align the section a few bytes.
> 
> The second patch introduce use of PAGE_SIZE as replacemnt of the
> hardcoded value 4096 and convert a few decimal numbers to hex.

Patches look good, I'll add them to the repository.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
