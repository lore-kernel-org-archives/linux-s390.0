Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43429 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727098AbgHSKWe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 19 Aug 2020 06:22:34 -0400
Date: Wed, 19 Aug 2020 12:22:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 2/4] scripts: add support for
 architecture dependent functions
Message-ID: <20200819122219.18a102dd.cohuck@redhat.com>
In-Reply-To: <20200818130424.20522-3-mhartmay@linux.ibm.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
        <20200818130424.20522-3-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Tue, 18 Aug 2020 15:04:22 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> This is necessary to keep architecture dependent code separate from
> common code.
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  README.md           | 3 ++-
>  scripts/common.bash | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
