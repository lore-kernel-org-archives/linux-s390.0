From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/5] s390: Virtual channel subsystem
	support.
Date: Wed, 8 Aug 2012 09:27:32 +0100
Message-ID: <CAFEAcA-LyZpCxxM5sJzV-zgNR78L6GkKg0EA9v0XUwc9fFLoWw@mail.gmail.com>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351173-2716-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1344351173-2716-3-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Sebastian Ott <sebott@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 7 August 2012 15:52, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> +static void sch_handle_clear_func(SubchDev *sch)
> +{
> +    struct pmcw *p = &sch->curr_status.pmcw;
> +    struct scsw *s = &sch->curr_status.scsw;
> +    int path;
> +
> +    /* Path management: In our simple css, we always choose the only path. */
> +    path = 0x80;
> +
> +    /* Reset values prior to 'issueing the clear signal'. */
> +    p->lpum = 0;

This is unnecessary since we're going to set p->lpum to something else about
ten lines later, right?

> +    p->pom = 0xff;
> +    s->pno = 0;
> +
> +    /* We always 'attempt to issue the clear signal', and we always succeed. */
> +    sch->orb = NULL;
> +    sch->channel_prog = NULL;
> +    sch->last_cmd = NULL;
> +    s->actl &= ~SCSW_ACTL_CLEAR_PEND;
> +    s->stctl |= SCSW_STCTL_STATUS_PEND;
> +
> +    s->dstat = 0;
> +    s->cstat = 0;
> +    p->lpum = path;
> +
> +}

-- PMM
