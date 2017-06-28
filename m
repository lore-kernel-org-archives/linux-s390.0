From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 9/9] KVM: s390: Inject machine check into the nested
 guest
Date: Wed, 28 Jun 2017 21:17:49 +0200
Message-ID: <41b84826-c286-4c41-2fe8-300e100ea60b@redhat.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
 <1498671044-81240-10-git-send-email-borntraeger@de.ibm.com>
 <9ec0f700-c686-44ce-c633-01f2b0ec46c0@redhat.com>
 <d4351d31-569e-4257-8b9d-b24c426fde58@de.ibm.com>
 <de970ef9-5fa4-1d58-b3d9-351c2a0ceb9e@redhat.com>
 <18e00d40-bdd4-84a9-f1b5-d4599aac74af@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <18e00d40-bdd4-84a9-f1b5-d4599aac74af@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


>> As mentioned in the other mail, e.g. vector register validity should
>> only be set if vector registers are enabled for the nested guest
>> (execution control enabled).
> 
> Yes, but sInce we inject in the base guest (non-nested) we have to check the base guest
> execution control. 
> 

Right, confusion due to nesting levels strikes again :)

-- 

Thanks,

David
