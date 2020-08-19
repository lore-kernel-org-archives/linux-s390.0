Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgHSKUe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 06:20:34 -0400
Date: Wed, 19 Aug 2020 12:20:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 1/4] common.bash: run `cmd` only if a
 test case was found
Message-ID: <20200819122021.43dd6ba6.cohuck@redhat.com>
In-Reply-To: <20200818130424.20522-2-mhartmay@linux.ibm.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
        <20200818130424.20522-2-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Tue, 18 Aug 2020 15:04:21 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> It's only useful to run `cmd` in `for_each_unittest` if a test case
> was found. This change allows us to remove the guards from the
> functions `run_task` and `mkstandalone`.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  run_tests.sh            | 3 ---
>  scripts/common.bash     | 8 ++++++--
>  scripts/mkstandalone.sh | 4 ----
>  3 files changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
