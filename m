From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] linux-headers: add new interfaces
Date: Tue, 18 Mar 2014 08:26:59 +0100
Message-ID: <20140318082659.766b77bf.cornelia.huck@de.ibm.com>
References: <1395079921-29325-1-git-send-email-cornelia.huck@de.ibm.com>
	<1395079921-29325-2-git-send-email-cornelia.huck@de.ibm.com>
	<CAFEAcA9Wq8R5h7iy0n_76pbWzJYLraUKCPC6CaP4akk76N0dBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAFEAcA9Wq8R5h7iy0n_76pbWzJYLraUKCPC6CaP4akk76N0dBw@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: kvm-devel <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, gleb@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 17 Mar 2014 18:24:08 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 17 March 2014 18:11, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > Per-vm capability enablement, adapter interrupt sources, irq routing on s390.
> >
> > Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> This is an RFC patchset, since these header changes
> aren't in upstream yet, right?

Yes, I'll do a proper sync patch once the header changes go upstream.
