From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 1/1] KVM: s390: gaccess: fix real-space designation
 asce handling for gmap shadows
Date: Thu, 22 Jun 2017 15:48:36 +0200
Message-ID: <aa7521ae-d9d6-de4f-7894-5e88f1338a03@redhat.com>
References: <1498138467-29808-1-git-send-email-borntraeger@de.ibm.com>
 <1498138467-29808-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1498138467-29808-2-git-send-email-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 22.06.2017 15:34, Christian Borntraeger wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> For real-space designation asces the asce origin part is only a token.
> The asce token origin must not be used to generate an effective
> address for storage references. This however is erroneously done
> within kvm_s390_shadow_tables().
> 
> Furthermore within the same function the wrong parts of virtual
> addresses are used to generate a corresponding real address
> (e.g. the region second index is used as region first index).
> 
> Both of the above can result in incorrect address translations. Only
> for real space designations with a token origin of zero and addresses
> below one megabyte the translation was correct.
> 
> Furthermore replace a "!asce.r" statement with a "!*fake" statement to
> make it more obvious that a specific condition has nothing to do with
> the architecture, but with the fake handling of real space designations.
> 
> Fixes: 3218f7094b6b ("s390/mm: support real-space for gmap shadows")
> Cc: David Hildenbrand <david@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David
