From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Thu, 28 Aug 2014 21:09:48 +0200
Message-ID: <53FF7E7C.1050804@de.ibm.com>
References: <cover.1409176034.git.luto@amacapital.net>
	<53FEDDF5.3030903@de.ibm.com>
	<CALCETrXxFJQsZyLmbrjYyXK6LKmRuBK=KMas2Db8vCVaBwe9yQ@mail.gmail.com>
	<53FF751D.2040006@de.ibm.com>
	<CALCETrWtZ8ZRDvcg8cCxS53zmUPZCpqKFuAEdurSXdR2yXsJSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWtZ8ZRDvcg8cCxS53zmUPZCpqKFuAEdurSXdR2yXsJSQ@mail.gmail.com>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux390@de.ibm.com" <linux390@de.ibm.com>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

On 28/08/14 20:51, Andy Lutomirski wrote:
>   if (i != total_sg) {
>                 printk(KERN_ERR "i=%d total_sg=%u total_out=%u total_in=%u out_\
> sgs=%u in_sgs=%u\n",
>                        i, total_sg, total_out, total_in, out_sgs, in_sgs);
>         }

i=1 total_sg=2 total_out=2 total_in=0 out_sgs=1 in_sgs=0
