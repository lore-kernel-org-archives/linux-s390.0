From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/6] s390/alternative: use a copy of the facility bit
 mask
Date: Wed, 17 Jan 2018 15:24:13 +0100
Message-ID: <20180117152413.312ee2fe.cohuck@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
        <1516182519-10623-2-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-2-git-send-email-schwidefsky@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Jan 2018 10:48:34 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> To be able to switch off specific CPU alternatives with kernel parameters
> make a copy of the facility bit mask provided by STFLE and use the copy
> for the decision to apply an alternative.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/include/asm/facility.h | 18 ++++++++++++++++++
>  arch/s390/include/asm/lowcore.h  |  3 ++-
>  arch/s390/kernel/alternative.c   |  3 ++-
>  arch/s390/kernel/early.c         |  3 +++
>  arch/s390/kernel/setup.c         |  4 +++-
>  arch/s390/kernel/smp.c           |  4 +++-
>  6 files changed, 31 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
