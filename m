Return-Path: <linux-kernel-owner+w=401wt.eu-S1757267AbZCLOqm@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.29-rc7,s390] System goes into endless loop during boot or logon
Date: Thu, 12 Mar 2009 15:46:04 +0100
References: <200903080835.14032.elendil@planet.nl> <200903091025.53284.elendil@planet.nl> <1236871686.19544.3.camel@localhost.localdomain>
In-Reply-To: <1236871686.19544.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903121546.06687.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jan Glauber <jang@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-s390@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thursday 12 March 2009, Jan Glauber wrote:
> > AFAICT s390 does not have an NMI watchdog. And I have no idea how I
> > could trigger a sysrq given that I can't login and only have a dumb
> > console or SSH session to work with anyway.
>
> You can try to trigger sysrq by ^-, so to get the task view type: .^-t

Thanks a lot Jan! On a running system that works, so now the only question 
is if it also works when the system is looping. Will try later.
