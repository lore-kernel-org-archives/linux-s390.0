Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405962AbfHIJE2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 9 Aug 2019 05:04:28 -0400
Date: Fri, 9 Aug 2019 11:04:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: change list for KVM/s390
Message-ID: <20190809110425.45a62e7a.cohuck@redhat.com>
In-Reply-To: <1565335156-28660-1-git-send-email-pbonzini@redhat.com>
References: <1565335156-28660-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Fri,  9 Aug 2019 09:19:16 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> KVM/s390 does not have a list of its own, and linux-s390 is in the
> loop anyway thanks to the generic arch/s390 match.  So use the generic
> KVM list for s390 patches.

Let's add the s390 list manually just for this patch, for awareness :)

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aec93695040..6498ebaca2f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8788,7 +8788,7 @@ M:	Christian Borntraeger <borntraeger@de.ibm.com>
>  M:	Janosch Frank <frankja@linux.ibm.com>
>  R:	David Hildenbrand <david@redhat.com>
>  R:	Cornelia Huck <cohuck@redhat.com>
> -L:	linux-s390@vger.kernel.org
> +L:	kvm@vger.kernel.org
>  W:	http://www.ibm.com/developerworks/linux/linux390/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>  S:	Supported

Yes, get_maintainers.pl should add in the s390 list, so that sounds
fine.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
