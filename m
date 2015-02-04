From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/7] s390/kernel: Update /proc/sysinfo file with Extended
 Name and UUID
Date: Wed, 04 Feb 2015 14:01:31 +0100
Message-ID: <54D2182B.9090800@de.ibm.com>
References: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com> <1423043092-34044-4-git-send-email-borntraeger@de.ibm.com> <54D21757.7020300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <54D21757.7020300@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Am 04.02.2015 um 13:57 schrieb Paolo Bonzini:
> 
> 
> On 04/02/2015 10:44, Christian Borntraeger wrote:
>> From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>>
>> Read the additional data fields (Extended Name and UUID) from the
>> 1KB block returned by the STSI command and reflect this information in
>> the /proc/sysinfo file accordingly
>>
>> Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
>> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Why should this go in via KVM? :)

Because we are being the first that will implement the architecture (
the other side so to speak). 
Heiko gave his ack so this shoudl be fine. If you prefer I can certainly push
that via Martin/Heiko.


Christian
