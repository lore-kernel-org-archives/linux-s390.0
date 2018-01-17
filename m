From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/6] s390/alternative: use a copy of the facility bit mask
Date: Wed, 17 Jan 2018 14:54:49 +0100
Message-ID: <d193d0eb-8b76-790a-a039-9cf1ee0966e9@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-2-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-2-git-send-email-schwidefsky@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On 17.01.2018 10:48, Martin Schwidefsky wrote:
> To be able to switch off specific CPU alternatives with kernel parameters
> make a copy of the facility bit mask provided by STFLE and use the copy
> for the decision to apply an alternative.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
