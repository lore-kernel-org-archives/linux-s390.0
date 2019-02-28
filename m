From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 16:27:15 +0000
Subject: Re: [kvm-unit-tests PATCH v2 1/3] s390x: Beautify sthyi report strings
Message-Id: <ca675888-3795-797a-57e6-0e28d48d9f13@redhat.com>
In-Reply-To: <20190228083539.146516-2-frankja@linux.ibm.com>
References: <20190228083539.146516-2-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 28/02/2019 09.35, Janosch Frank wrote:
> Tests like the register odd check in r1 and r2 were not
> distinguishable and the reports were hard to read in total.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/sthyi.c | 52 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 20 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

... and queued all three patches for the next pull request now.
