From: Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Dec 2018 12:19:16 +0000
Subject: Re: [kvm-unit-tests PATCH v2 1/6] s390x: Cleanup sclp-ascii.c and add sigp order definitions
Message-Id: <ff76d599-1a8f-b045-eb93-a641f745445f@redhat.com>
In-Reply-To: <50860c4d-f2d5-5216-16ec-608066ca691f@redhat.com>
References: <50860c4d-f2d5-5216-16ec-608066ca691f@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2018-12-05 16:39, Janosch Frank wrote:
> Let's fix sclp-ascii.c indentation and rename it to sclp-console.c
> 
> Also adding sigp order codes to remove magic numbers from io.c.
> 

In case you respin, I agree with David, please break this up into two
patches. Otherwise:

Reviewed-by: Thomas Huth <thuth@redhat.com>
