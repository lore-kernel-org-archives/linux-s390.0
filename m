From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/4] Preview: vcpu lookup by id changes
Date: Thu, 19 Nov 2015 10:51:11 +0100
Message-ID: <564D9B8F.2070703@de.ibm.com>
References: <1447922251-54261-1-git-send-email-borntraeger@de.ibm.com>
 <564D98AA.70909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <564D98AA.70909@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/19/2015 10:38 AM, Paolo Bonzini wrote:
> 
> 
> On 19/11/2015 09:37, Christian Borntraeger wrote:
>>
>> some more patches for review before I add them in my next pull request.
>> Can you review the common code changes and Ack/Nack?
>>
>> Alex, Paul,
>> can you review the power changes and Ack/Nack? 
>>
>> As I want to have patch 2 in 4.4, I splitted up Davids patch into smaller
>> chunks. David, can you double check that I did not mess up?
>> So I want to send patch 1 and patch 2 for 4.4. Patch 3 and Patch 4
>> are for kvm/next (4.5), but need patch 1 as well. 
>> So I will probably also add all patches into kvm/next by setting up
>> the git branches in a way that during 4.5 merge window kvm/next will
>> have my branch that will go via kvm/master as common ancestor.
>>
>> Ok?
> 
> Patches and plan both look good!
> 
> I can apply patch 1 and 2 now to kvm/master.  By the time kvm/next forks
> from Linus's tree (sometime next week, since kvm/queue is already
> largish) they will be in.

I have 2or 3 more patches for 4.4 and I will prepare a pull request today. So
either take them or wait for my request. Whatever works best for you.
