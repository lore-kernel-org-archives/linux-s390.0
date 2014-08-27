From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/3] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 27 Aug 2014 07:46:46 +0100
Message-ID: <CAJSP0QUcXQ+JV0wys2Mr-+OsFKt=hTGbUxNqfpk-JuyULiQABQ@mail.gmail.com>
References: <cover.1409087794.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1409087794.git.luto@amacapital.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux390@de.ibm.com, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 26, 2014 at 10:16 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> There are two outstanding issues.  virtio_net warns if DMA debugging
> is on because it does DMA from the stack.  (The warning is correct.)
> This also is likely to do something unpleasant to s390.
> (Maintainers are cc'd -- I don't know what to do about it.)

This changes the semantics of vring and breaks existing guests when
bus address != physical address.

Can you use a transport feature bit to indicate that bus addresses are
used?  That way both approaches can be supported.

Please also update the virtio specification:
https://tools.oasis-open.org/version-control/browse/wsvn/virtio/

Stefan
