Return-Path: <linux-kernel-owner+w=401wt.eu-S1758114AbXFSLJ7@vger.kernel.org>
Subject: Re: [patch 5/6] Move psw_set_key.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070619093456.GB8684@osiris.boeblingen.de.ibm.com>
References: <20070619084516.457715754@de.ibm.com>
	 <20070619084642.673859525@de.ibm.com>
	 <20070619091200.GA1277@wavehammer.waldi.eu.org>
	 <20070619093456.GB8684@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 13:11:19 +0200
Message-Id: <1182251479.29887.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Bastian Blank <bastian@waldi.eu.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2007-06-19 at 11:34 +0200, Heiko Carstens wrote:
> > > Move psw_set_key() from ptrace.h to processor.h which is a more
> > > suitable place for it. In addition the moves makes the function
> > > invisible to user space.
> > 
> > Hmm, this does not really describe the changes.
> 
> Yes.. you need to interchange descriptions for patches 5 & 6. Then it
> might make sense ;)

Ahem, yes, oops.. sorry.

Fixed on git390.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
