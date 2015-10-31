From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 1/6] virtio-net: Stop doing DMA from the stack
Date: Fri, 30 Oct 2015 22:02:17 -0700
Message-ID: <CALCETrVvoAfQSUGhquNHEK1sSuAz=8QXp8OGAE+rjX207vS_-w@mail.gmail.com>
References: <cover.1446162273.git.luto@kernel.org>
	<8d6b1fc3b5d3b6f5e8b212ef690691a52fbefaff.1446162273.git.luto@kernel.org>
	<563376D2.20502@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <563376D2.20502@de.ibm.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 30, 2015 at 6:55 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> Am 30.10.2015 um 02:09 schrieb Andy Lutomirski:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>>
>> Once virtio starts using the DMA API, we won't be able to safely DMA
>> from the stack.  virtio-net does a couple of config DMA requests
>> from small stack buffers -- switch to using dynamically-allocated
>> memory.
>>
>> This should have no effect on any performance-critical code paths.
>>
>> [I wrote the subject and commit message.  mst wrote the code. --luto]
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> I still get an error when using multiqueue:
>
> #  ethtool -L eth0 combined 4
> [   33.534686] virtio_ccw 0.0.000d: DMA-API: device driver maps memory from stack [addr=00000000629e7c06]

Fixed in my branch, I think.

--Andy
