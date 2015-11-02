From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/3] alpha: use common noop dma ops
Date: Mon, 2 Nov 2015 16:18:11 +0100
Message-ID: <20151102151811.GD2876@suse.de>
References: <1446211237-111298-1-git-send-email-borntraeger@de.ibm.com>
	<1446211237-111298-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1446211237-111298-3-git-send-email-borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 30, 2015 at 02:20:36PM +0100, Christian Borntraeger wrote:
> Some of the alpha pci noop dma ops are identical to the common ones.
> Use them.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/alpha/kernel/pci-noop.c | 46 ++++----------------------------------------
>  1 file changed, 4 insertions(+), 42 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
