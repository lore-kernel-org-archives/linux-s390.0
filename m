From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [FIXUP v9] fixup! fixup! s390: doc: detailed specifications for
 AP virtualization
Date: Fri, 28 Sep 2018 15:45:51 +0200
Message-ID: <e3af12e4-3b12-b2d7-712d-766fdd2c4e1e@de.ibm.com>
References: <20180926164222.74731b74@t450s.home>
 <20180928134306.1395-1-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928134306.1395-1-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 09/28/2018 03:43 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Removes extraneous text from third line below:
> 
> +05          CEX5A Accelerator
> +05.0047     CEX5A Accelerator
> +05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ---
>  Documentation/s390/vfio-ap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
> index 599eb0f75c07..6a880a27cfb6 100644
> --- a/Documentation/s390/vfio-ap.txt
> +++ b/Documentation/s390/vfio-ap.txt
> @@ -459,7 +459,7 @@ CARD.DOMAIN TYPE  MODE
>  ------------------------------
>  05          CEX5A Accelerator
>  05.0047     CEX5A Accelerator
> -05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
> +05.00ff     CEX5A Accelerator
>  
>  Guest2
>  ------

Folded in.
