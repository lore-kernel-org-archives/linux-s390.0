From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 10/25] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Fri, 22 Apr 2016 16:28:46 +0100
Message-ID: <20160422152845.GO2998@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-11-git-send-email-ynorov@caviumnetworks.com>
 <570F0C7D.8000004@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570F0C7D.8000004@huawei.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, heiko.carstens@de.ibm.com, linux-doc@vger.kernel.org, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, broonie@kernel.org, Andrew Pinski <apinski@cavium.com>, schwab@suse.de, schwidefsky@de.ibm.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 14, 2016 at 11:20:29AM +0800, Zhangjian (Bamvor) wrote:
> I suggest we enable AARCH32_EL0 by default explicitly. I am not sure
> if it should be a dedicated commit. I am ok if you merge my commit, add

We currently enable COMPAT in defconfig. I think we keep the same
approach and change CONFIG_COMPAT to CONFIG_AARCH32_EL0 in defconfig.

-- 
Catalin
