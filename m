Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Mar 2015 15:09:49 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] livepatch: add support on s390
In-Reply-To: <20150327135848.GB4379@osiris>
Message-ID: <alpine.LNX.2.00.1503271501210.6781@pobox.suse.cz>
References: <1427361017-23354-1-git-send-email-jslaby@suse.cz> <alpine.LNX.2.00.1503261924430.6781@pobox.suse.cz> <20150327091900.GA4379@osiris> <alpine.LNX.2.00.1503271020470.6781@pobox.suse.cz> <20150327135848.GB4379@osiris>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Slaby <jslaby@suse.cz>, jpoimboe@redhat.com, sjenning@redhat.com, vojtech@suse.cz, live-patching@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 27 Mar 2015, Heiko Carstens wrote:

> > Fair enough; I merged it because I was convinced that we have your Ack for 
> > the very same patch in our tree for kGraft, but now that I look again, we 
> > apparently don't. So sorry for that. What is your standpoint on this one 
> > then, please?
> 
> I thought there was more available then the simple testcase within the kernel.

For kGraft we have, and I believe kPatch guys also have patches they are 
distributing for their own distro.

So far we have the simplest testcases working with the in-kernel common 
infrastructure, and are working on adding more features (called 
"consistency models" in some discussions) that will allow for more 
complexity in the patches, so that we ultimately reach (or overcome) the 
level of complexity we are currently able to handle in kgraft/kpatch.

> But since the testcase works:
> 
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks a lot, Heiko.

As I am generally never rebasing a published branches, I've split the 
'for-4.1/core' to two branches and applied the patch ammended with your 
Ack to 'for-4.1/core-s390'.

-- 
Jiri Kosina
SUSE Labs
