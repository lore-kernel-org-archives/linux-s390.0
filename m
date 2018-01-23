From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 5/5] s390: scrub registers on kernel entry and KVM exit
Date: Tue, 23 Jan 2018 14:09:50 +0100
Message-ID: <7bb93e6b-4465-9149-157b-57d28becb1e9@de.ibm.com>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
 <1516712825-2917-6-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516712825-2917-6-git-send-email-schwidefsky@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>



On 01/23/2018 02:07 PM, Martin Schwidefsky wrote:
> Clear all user space registers on entry to the kernel and all KVM guest
> registers on KVM guest exit if the register does not contain either a
> parameter or a result value.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

you dropped my reviewed-by. Has this patch changed?
