From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 00/26] guest dedicated crypto adapters
Date: Mon, 24 Sep 2018 13:53:08 +0200
Message-ID: <20180924135308.3fc89eeb.cohuck@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <2d877c7c-1c81-bde7-7582-22feff4759bd@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2d877c7c-1c81-bde7-7582-22feff4759bd@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 24 Sep 2018 12:10:37 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> FWIW, assuming that review comments for v10 will be addresses in v11, I plan to
> add the upcoming v11 to a topic branch and will merge that after 2 or 3 days after
> v11 in kvms390/next.

As said before, I think this looks sane enough to merge with the
requested changes.

> In the future the vfio-ap driver will likely be handled by
> Martins s390 tree, so I guess it makes sense for him to merge the upcoming
> topic branch as well. I will coordinate with Martin.

I assume future patches will still be posted to kvm + linux-s390 for
review?
