Return-Path: <owner-linux-mm@kvack.org>
Date: Thu, 24 Jul 2014 21:53:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/5] mm, shmem: Add shmem_vma() helper
Message-ID: <20140724195302.GA28972@redhat.com>
References: <1406036632-26552-1-git-send-email-jmarchan@redhat.com> <1406036632-26552-4-git-send-email-jmarchan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1406036632-26552-4-git-send-email-jmarchan@redhat.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, Hugh Dickins <hughd@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <a.p.zijls@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/22, Jerome Marchand wrote:
>
> +bool shmem_vma(struct vm_area_struct *vma)
> +{
> +	return (vma->vm_file &&
> +		vma->vm_file->f_dentry->d_inode->i_mapping->backing_dev_info
> +		== &shmem_backing_dev_info);
> +
> +}

Cosmetic nit, it seems that this helper could simply do

	return vma->vm_file && shmem_mapping(file_inode(vma->vm_file));

Oleg.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
