From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Mon, 13 Sep 2010 11:41:56 +0200
Message-ID: <4C8DF1E4.7020604@redhat.com>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>	<72A751CE-3F46-4D98-9FAF-BA1C1A95B6EE@suse.de>	<4C8C96BB.2010804@redhat.com>	<201009131305.58893.rusty@rustcorp.com.au> <20100913094113.3c0ee732@mschwide.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20100913094113.3c0ee732@mschwide.boeblingen.de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Graf <agraf@suse.de>, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

  On 09/13/2010 09:41 AM, Martin Schwidefsky wrote:
>>> Actually Marcelo applied it.  But the natural place for it is Rusty's
>>> virtio tree.  Rusty, if you want to take it, let me know and I'll drop
>>> it from kvm.git.
>> I thought it would be in the s390 tree, which is why I didn't take it...
>>
>> But I'm *always* happy to let do the work!
> I didn't pick them up after I saw that Marcelo took them. If others want
> to do the work, be my guest..
>

I just hope that all this generosity doesn't lead to merge conflicts 
later, or people basing their stuff on stale code.  But it isn't like 
this is a high churn area.

-- 
error compiling committee.c: too many arguments to function
