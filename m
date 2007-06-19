Return-Path: <linux-kernel-owner+w=401wt.eu-S1756754AbXFSJfX@vger.kernel.org>
Date: Tue, 19 Jun 2007 11:34:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 5/6] Move psw_set_key.
Message-ID: <20070619093456.GB8684@osiris.boeblingen.de.ibm.com>
References: <20070619084516.457715754@de.ibm.com> <20070619084642.673859525@de.ibm.com> <20070619091200.GA1277@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070619091200.GA1277@wavehammer.waldi.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bastian Blank <bastian@waldi.eu.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 19, 2007 at 11:12:00AM +0200, Bastian Blank wrote:
> On Tue, Jun 19, 2007 at 10:45:21AM +0200, Martin Schwidefsky wrote:
> > Move psw_set_key() from ptrace.h to processor.h which is a more
> > suitable place for it. In addition the moves makes the function
> > invisible to user space.
> 
> Hmm, this does not really describe the changes.

Yes.. you need to interchange descriptions for patches 5 & 6. Then it
might make sense ;)
