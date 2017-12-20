From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC/PATCH v2 22/22] RFC: s390/mm: Add gmap lock classes
Date: Wed, 20 Dec 2017 13:24:57 +0100
Message-ID: <875a7110-e255-2690-c8bc-8d7665a9f63a@de.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-23-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-23-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 12/13/2017 01:53 PM, Janosch Frank wrote:
> A shadow gmap and its parent are locked right after each other when
> doing VSIE management. Lockdep can't differentiate between the two
> classes without some help.
> 
> TODO: Not sure yet if I have to annotate all and if gmap_pmd_walk will
> be used by both shadow and parent


I  think the annotations are just fine here.

> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/gmap.h |  6 ++++++
>  arch/s390/mm/gmap.c          | 40 +++++++++++++++++++---------------------
>  2 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index a187033..6287aca 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -20,6 +20,12 @@
>  #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
>  #define _SEGMENT_ENTRY_GMAP_VSIE	0x8000	/* vsie bit */
> 
> +
> +enum gmap_lock_class {
> +	GMAP_LOCK_PARENT,
> +	GMAP_LOCK_SHADOW
> +};
> +
>  /**
>   * struct gmap_struct - guest address space
>   * @list: list head for the mm->context gmap list
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index cb03646..86a12f3 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -199,10 +199,8 @@ static void gmap_free(struct gmap *gmap)
>  	gmap_radix_tree_free(&gmap->host_to_guest);
> 
>  	/* Free split pmd page tables */
> -	spin_lock(&gmap->guest_table_lock);
>  	list_for_each_entry_safe(page, next, &gmap->split_list, lru)
>  		page_table_free_pgste(page);
> -	spin_unlock(&gmap->guest_table_lock);

Any reason why you only remove these?
