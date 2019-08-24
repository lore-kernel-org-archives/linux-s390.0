Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 24 Aug 2019 15:41:32 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V5 1/5] iommu/amd: Remove unnecessary locking from AMD
 iommu driver
Message-ID: <20190824224132.GA14806@infradead.org>
References: <20190815110944.3579-1-murphyt7@tcd.ie>
 <20190815110944.3579-2-murphyt7@tcd.ie>
 <20190820094143.GA24154@infradead.org>
 <CALQxJussiGDzWFT1xhko6no5jZNOezWCFuJQUCr4XwH4NHri3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQxJussiGDzWFT1xhko6no5jZNOezWCFuJQUCr4XwH4NHri3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Murphy <murphyt7@tcd.ie>
Cc: Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>

Thank for the explanation Tom. It might make sense to add a condensed
version of it to commit log for the next iteration.
