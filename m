From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 22 Jan 2019 16:46:45 +0000
Subject: Re: [RFC v1 2/2] vfio-ccw: Don't exit early if state of the vfio-ccw subchannel is not idle
Message-Id: <20190122174645.141d8c3b.cohuck@redhat.com>
In-Reply-To: <20190122174307.0977f475.cohuck@redhat.com>
References: <20190122174307.0977f475.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 22 Jan 2019 10:19:29 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> The test setup basically runs fio (sequential, random) read and write 
> workloads for a long period of time. I run each workload at least for 5 
> minutes and keep running them in a continuous loop for few hours.

Ok, this is more intensive testing than what I'm doing :) (basically
some dd and some tunedasd calls)

> 
> Also I am testing with Hyper PAV, so I run the workloads with different 
> number of HPAVs for a base device.

Ok, I don't have PAV in my setup.
