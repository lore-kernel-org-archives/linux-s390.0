From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH v2 1/7] s390/kvm: Support for I/O
	interrupts.
Date: Wed, 05 Sep 2012 10:28:53 +0300
Message-ID: <5046FF35.6050403@redhat.com>
References: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771610-52423-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1346771610-52423-2-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 09/04/2012 06:13 PM, Cornelia Huck wrote:
> Add support for handling I/O interrupts (standard, subchannel-related
> ones and rudimentary adapter interrupts).
> 
> The subchannel-identifying parameters are encoded into the interrupt
> type.
> 
> I/O interrupts are floating, so they can't be injected on a specific
> vcpu.
> 
> diff --git a/include/linux/kvm.h b/include/linux/kvm.h
> index d808694..5a36e65 100644
> --- a/include/linux/kvm.h
> +++ b/include/linux/kvm.h
> @@ -396,6 +396,12 @@ struct kvm_s390_psw {
>  #define KVM_S390_INT_SERVICE		0xffff2401u
>  #define KVM_S390_INT_EMERGENCY		0xffff1201u
>  #define KVM_S390_INT_EXTERNAL_CALL	0xffff1202u
> +#define KVM_S390_INT_IO(ai,cssid,ssid,schid)   \
> +	(((schid)) |			       \
> +	 ((ssid) << 16) |		       \
> +	 ((cssid) << 18) |		       \
> +	 ((ai) << 26))
> +
>  

Documentation?


-- 
error compiling committee.c: too many arguments to function
