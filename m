From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 5/5] s390: scrub registers on kernel entry and KVM exit
Date: Tue, 23 Jan 2018 15:32:17 +0100
Message-ID: <20180123153217.3bff6f53@mschwideX1>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
        <1516712825-2917-6-git-send-email-schwidefsky@de.ibm.com>
        <7bb93e6b-4465-9149-157b-57d28becb1e9@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7bb93e6b-4465-9149-157b-57d28becb1e9@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 Jan 2018 14:09:50 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 01/23/2018 02:07 PM, Martin Schwidefsky wrote:
> > Clear all user space registers on entry to the kernel and all KVM guest
> > registers on KVM guest exit if the register does not contain either a
> > parameter or a result value.
> > 
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>  
> 
> you dropped my reviewed-by. Has this patch changed?

To drop something I have to add it in the first place..
But the patch did not change and your r-b tag is added now.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
