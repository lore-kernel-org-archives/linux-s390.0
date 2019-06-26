Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfFZLmw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 07:42:52 -0400
Date: Wed, 26 Jun 2019 13:42:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 1/2] s390/setup: diag318: refactor struct
Message-ID: <20190626134247.532ac998.cohuck@redhat.com>
In-Reply-To: <1561475022-18348-2-git-send-email-walling@linux.ibm.com>
References: <1561475022-18348-1-git-send-email-walling@linux.ibm.com>
        <1561475022-18348-2-git-send-email-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>
Cc: david@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On Tue, 25 Jun 2019 11:03:41 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> The diag318 struct introduced in include/asm/diag.h can be
> reused in KVM, so let's condense the version code fields in the
> diag318_info struct for easier usage and simplify it until we
> can determine how the data should be formatted.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/include/asm/diag.h | 6 ++----
>  arch/s390/kernel/setup.c     | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
