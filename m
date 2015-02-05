From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/7] s390/kernel: Update /proc/sysinfo file with Extended
 Name and UUID
Date: Thu, 05 Feb 2015 12:13:23 +0100
Message-ID: <54D35053.2020900@redhat.com>
References: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com> <1423043092-34044-4-git-send-email-borntraeger@de.ibm.com> <54D21757.7020300@redhat.com> <54D2182B.9090800@de.ibm.com> <54D218B8.7050201@redhat.com> <54D273B4.1080009@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <54D273B4.1080009@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 04/02/2015 20:32, Christian Borntraeger wrote:
> 
> A new architecture extends STSI 3.2.2 with UUID and long names. KVM will
> provide the first implementation. This patch adds the additional data 
> fields (Extended Name and UUID) from the 4KB block returned by the STSI 
> 3.2.2 command and reflect this information in the /proc/sysinfo file
> accordingly. 

Great.

> This is is non-KVM code, but developed by the KVM team. The patch is 
> acked by Heiko Carstens to go over the KVM tree.

The last two lines are not even necessary (the explanation of "why" is
in the first paragraph, the explanation of "how" is in the
Signed-off-bys and Acked-by).

Paolo

> Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
