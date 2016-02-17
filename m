From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 0/9] virtio DMA API, yet again
Date: Wed, 17 Feb 2016 11:29:03 +0200
Message-ID: <20160217112747-mutt-send-email-mst@redhat.com>
References: <cover.1454477782.git.luto@kernel.org>
	<CALCETrXtcL18QnouuNQavDNPvSSf54KxRviGZC3yJD7jECTqcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXtcL18QnouuNQavDNPvSSf54KxRviGZC3yJD7jECTqcQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 16, 2016 at 09:48:58PM -0800, Andy Lutomirski wrote:
> On Tue, Feb 2, 2016 at 9:46 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > This switches virtio to use the DMA API on Xen and if requested by
> > module option.
> 
> Michael, any update on this?
> 
> --Andy

I was hoping for an explicit ack from David Woodhouse,
but I guess the informal "let's not hold this up"
that was sent on v5 will do.

I've queued this up for 4.6, thanks everyone!

-- 
MST
