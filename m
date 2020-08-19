Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58520 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726851AbgHSKYI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 06:24:08 -0400
Date: Wed, 19 Aug 2020 12:23:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 3/4] run_tests/mkstandalone: add arch_cmd
 hook
Message-ID: <20200819122354.3b9c9bbb.cohuck@redhat.com>
In-Reply-To: <20200818130424.20522-4-mhartmay@linux.ibm.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
        <20200818130424.20522-4-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Tue, 18 Aug 2020 15:04:23 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> This allows us, for example, to auto generate a new test case based on
> an existing test case.
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  scripts/common.bash | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
