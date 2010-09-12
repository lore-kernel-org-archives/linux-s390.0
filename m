From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Sun, 12 Sep 2010 11:00:43 +0200
Message-ID: <4C8C96BB.2010804@redhat.com>
References: <1282657732-20902-1-git-send-email-agraf@suse.de> <1282657732-20902-2-git-send-email-agraf@suse.de> <72A751CE-3F46-4D98-9FAF-BA1C1A95B6EE@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <72A751CE-3F46-4D98-9FAF-BA1C1A95B6EE@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>
List-ID: <linux-s390.vger.kernel.org>

  On 09/12/2010 02:42 AM, Alexander Graf wrote:
> On 24.08.2010, at 15:48, Alexander Graf wrote:
>
>> The one big missing feature in s390-virtio was hotplugging. This is no more.
>> This patch implements hotplug add support, so you can on the fly add new devices
>> in the guest.
>>
>> Keep in mind that this needs a patch for qemu to actually leverage the
>> functionality.
>>
>> Signed-off-by: Alexander Graf<agraf@suse.de>
> ping (on the patch set)?
>

Actually Marcelo applied it.  But the natural place for it is Rusty's 
virtio tree.  Rusty, if you want to take it, let me know and I'll drop 
it from kvm.git.

-- 
error compiling committee.c: too many arguments to function
