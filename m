From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 0/9] virtio DMA API, yet again
Date: Tue, 16 Feb 2016 21:48:58 -0800
Message-ID: <CALCETrXtcL18QnouuNQavDNPvSSf54KxRviGZC3yJD7jECTqcQ@mail.gmail.com>
References: <cover.1454477782.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 2, 2016 at 9:46 PM, Andy Lutomirski <luto@kernel.org> wrote:
> This switches virtio to use the DMA API on Xen and if requested by
> module option.

Michael, any update on this?

--Andy
