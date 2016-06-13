Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/oprofile: Remove deprecated create_workqueue
References: <20160607215912.GA19722@Karyakshetra>
 <20160609090056.GC3250@osiris> <20160613162914.GK25086@rric.localdomain>
From: William Cohen <wcohen@redhat.com>
Message-ID: <bc80939c-0523-60e9-5244-8b7c7b5e26fd@redhat.com>
Date: Mon, 13 Jun 2016 16:44:19 -0400
MIME-Version: 1.0
In-Reply-To: <20160613162914.GK25086@rric.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Robert Richter <rric@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tejun Heo <tj@kernel.org>, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Andreas Arnez <arnez@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 06/13/2016 12:29 PM, Robert Richter wrote:
> Heiko,
> 
> On 09.06.16 11:00:56, Heiko Carstens wrote:
>> However I'm wondering if we shouldn't simply remove at least the s390
>> specific hwswampler code from the oprofile module. This would still leave
>> the common code timer based sampling mode for oprofile working on s390.
>>
>> It looks like the oprofile user space utility nowadays (since 2012) uses
>> the kernel perf interface instead of the oprofile interface anyway, if
>> present. So the oprofile module itself doesn't seem to have too many users
>> left.
>>
>> Any opinions?
> 
> yes, the kernel driver is not necessary for oprofile userland for a
> while now. There is no ongoing development any longer, most patches
> are due to changes in the kernel apis.
> 
> So if there is code that needs a larger rework due to other kernel
> changes and there is no user anymore, I am fine with removing the code
> instead of reworking it. I still would just keep existing code as long
> as we can keep it unchanged (some like the lightwight of oprofile,
> esp. in the embedded space). If there is a user of the code, a
> Tested-by would be good for new code changes.
> 
> If there are users of the hwswampler, speak up now. Else, let's just
> remove it.
> 
> -Robert
> 

Hi,

As Robert mentioned the user-space oprofile code that would have used the oprofile device driver was removed around August 2014 in preparation for oprofile-1.0. The operf command which uses the kernel perf infrastructure and does not need for the oprofile kernel driver has been in oprofile since August of 2012.  For some architectures it would make sense to simplify things by eliminate the oprofile kernel driver.

-Will Cohen
